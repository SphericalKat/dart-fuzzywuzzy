import 'structs/edit_op.dart';
import 'structs/edit_type.dart';
import 'structs/matching_block.dart';
// import 'structs/op_code.dart';

class DiffUtils {
  static List<EditOp> getEditOps(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    int len1o, len2o;
    int i;

    List<int> matrix;

    var c1 = s1.runes.toList();
    var c2 = s2.runes.toList();

    int p1 = 0;
    int p2 = 0;

    len1o = 0;

    while (len1 > 0 && len2 > 0 && c1[p1] == c2[p2]) {
      len1--;
      len2--;

      p1++;
      p2++;

      len1o++;
    }

    len2o = len1o;

    // strip common prefix
    while (len1 > 0 && len2 > 0 && c1[p1 + len1 - 1] == c2[p2 + len2 - 1]) {
      len1--;
      len2--;
    }

    len1++;
    len2++;

    matrix = List.filled(len2 * len1, 0);

    for (i = 0; i < len2; i++) {
      matrix[i] = i;
    }

    for (i = 1; i < len1; i++) {
      matrix[len2 * i] = i;
    }

    for (i = 1; i < len1; i++) {
      int ptrPrev = (i - 1) * len2;
      int ptrC = i * len2;
      int ptrEnd = ptrC + len2 - 1;

      var char1 = c1[p1 + i - 1];
      int ptrChar2 = p2;

      int x = i;

      ptrC++;

      while (ptrC <= ptrEnd) {
        int c3 = matrix[ptrPrev++] + (char1 != c2[ptrChar2++] ? 1 : 0);
        x++;

        if (x > c3) {
          x = c3;
        }

        c3 = matrix[ptrPrev] + 1;

        if (x > c3) {
          x = c3;
        }

        matrix[ptrC++] = x;
      }
    }

    return _editOpsFromCostMatrix(
        len1, c1, p1, len1o, len2, c2, p2, len2o, matrix);
  }

  static List<EditOp> _editOpsFromCostMatrix(int len1, List<int> c1, int p1,
      int o1, int len2, List<int> c2, int p2, int o2, List<int> matrix) {
    int i, j, pos;

    int ptr;

    List<EditOp> ops;

    int dir = 0;

    pos = matrix[len1 * len2 - 1];
    ops = List.filled(pos, EditOp());

    i = len1 - 1;
    j = len2 - 1;

    ptr = len1 * len2 - 1;

    while (i > 0 || j > 0) {
      if (i != 0 &&
          j != 0 &&
          matrix[ptr] == matrix[ptr - len2 - 1] &&
          c1[p1 + i - 1] == c2[p2 + j - 1]) {
        i--;
        j--;
        ptr -= len2 + 1;
        dir = 0;

        continue;
      }

      if (dir < 0 && j != 0 && matrix[ptr] == matrix[ptr - 1] + 1) {
        EditOp eop = EditOp();

        pos--;
        ops[pos] = eop;
        eop.type = EditType.INSERT;
        eop.spos = i + o1;
        eop.dpos = --j + o2;
        ptr--;

        continue;
      }

      if (dir > 0 && i != 0 && matrix[ptr] == matrix[ptr - len2] + 1) {
        EditOp eop = EditOp();

        pos--;
        ops[pos] = eop;
        eop.type = EditType.DELETE;
        eop.spos = --i + o1;
        eop.dpos = j + o2;
        ptr -= len2;

        continue;
      }

      if (i != 0 && j != 0 && matrix[ptr] == matrix[ptr - len2 - 1] + 1) {
        pos--;

        EditOp eop = EditOp();
        ops[pos] = eop;

        eop.type = EditType.REPLACE;
        eop.spos = --i + o1;
        eop.dpos = --j + o2;

        ptr -= len2 + 1;
        dir = 0;
        continue;
      }

      if (dir == 0 && j != 0 && matrix[ptr] == matrix[ptr - 1] + 1) {
        pos--;
        EditOp eop = EditOp();
        ops[pos] = eop;
        eop.type = EditType.INSERT;
        eop.spos = i + o1;
        eop.dpos = --j + o2;
        ptr--;
        dir = -1;

        continue;
      }

      if (dir == 0 && i != 0 && matrix[ptr] == matrix[ptr - len2] + 1) {
        pos--;
        EditOp eop = new EditOp();
        ops[pos] = eop;

        eop.type = EditType.DELETE;
        eop.spos = --i + o1;
        eop.dpos = j + o2;
        ptr -= len2;
        dir = 1;
        continue;
      }

      assert(false);
    }

    return ops;
  }

  static List<MatchingBlock> getMatchingBlocks(String s1, String s2) {
    return _getMatchingBlocks(s1.length, s2.length, getEditOps(s1, s2));
  }

  // static List<MatchingBlock> _getMatchingBlocksFromOpcodes(
  //     int len1, int len2, List<OpCode> ops) {
  //   int n = ops.length;

  //   int noOfMB, i;
  //   int o = 0;

  //   noOfMB = 0;

  //   for (i = n; i-- != 0; o++) {
  //     if (ops[o].type == EditType.KEEP) {
  //       noOfMB++;

  //       while (i != 0 && ops[o].type == EditType.KEEP) {
  //         i--;
  //         o++;
  //       }

  //       if (i == 0) break;
  //     }
  //   }

  //   List<MatchingBlock> matchingBlocks =
  //       new List.filled(noOfMB + 1, MatchingBlock());
  //   int mb = 0;
  //   o = 0;
  //   matchingBlocks[mb] = new MatchingBlock();

  //   for (i = n; i != 0; i--, o++) {
  //     if (ops[o].type == EditType.KEEP) {
  //       matchingBlocks[mb].spos = ops[o].sbeg;
  //       matchingBlocks[mb].dpos = ops[o].dbeg;

  //       while (i != 0 && ops[o].type == EditType.KEEP) {
  //         i--;
  //         o++;
  //       }

  //       if (i == 0) {
  //         matchingBlocks[mb].length = len1 - matchingBlocks[mb].spos!;
  //         mb++;
  //         break;
  //       }

  //       matchingBlocks[mb].length = ops[o].sbeg! - matchingBlocks[mb].spos!;
  //       mb++;
  //       matchingBlocks[mb] = new MatchingBlock();
  //     }
  //   }

  //   assert(mb == noOfMB);

  //   MatchingBlock finalBlock = new MatchingBlock();
  //   finalBlock.spos = len1;
  //   finalBlock.dpos = len2;
  //   finalBlock.length = 0;

  //   matchingBlocks[mb] = finalBlock;

  //   return matchingBlocks;
  // }

  static List<MatchingBlock> _getMatchingBlocks(
      int len1, int len2, List<EditOp> ops) {
    int n = ops.length;

    int numberOfMatchingBlocks, i, spos, dpos;

    numberOfMatchingBlocks = 0;

    int o = 0;

    spos = dpos = 0;

    EditType type;

    for (i = n; i != 0;) {
      while (ops[o].type == EditType.KEEP && --i != 0) {
        o++;
      }

      if (i == 0) break;

      if (spos < ops[o].spos! || dpos < ops[o].dpos!) {
        numberOfMatchingBlocks++;
        spos = ops[o].spos!;
        dpos = ops[o].dpos!;
      }

      type = ops[o].type!;

      switch (type) {
        case EditType.REPLACE:
          do {
            spos++;
            dpos++;
            i--;
            o++;
          } while (i != 0 &&
              ops[o].type == type &&
              spos == ops[o].spos &&
              dpos == ops[o].dpos);
          break;

        case EditType.DELETE:
          do {
            spos++;
            i--;
            o++;
          } while (i != 0 &&
              ops[o].type == type &&
              spos == ops[o].spos &&
              dpos == ops[o].dpos);
          break;

        case EditType.INSERT:
          do {
            dpos++;
            i--;
            o++;
          } while (i != 0 &&
              ops[o].type == type &&
              spos == ops[o].spos &&
              dpos == ops[o].dpos);
          break;

        default:
          break;
      }
    }

    if (spos < len1 || dpos < len2) {
      numberOfMatchingBlocks++;
    }

    List<MatchingBlock> matchingBlocks =
        List.filled(numberOfMatchingBlocks + 1, MatchingBlock());

    o = 0;
    spos = dpos = 0;
    int mbIndex = 0;

    for (i = n; i != 0;) {
      while (ops[o].type == EditType.KEEP && --i != 0) o++;

      if (i == 0) break;

      if (spos < ops[o].spos! || dpos < ops[o].dpos!) {
        MatchingBlock mb = new MatchingBlock();

        mb.spos = spos;
        mb.dpos = dpos;
        mb.length = ops[o].spos! - spos;
        spos = ops[o].spos!;
        dpos = ops[o].dpos!;

        matchingBlocks[mbIndex++] = mb;
      }

      type = ops[o].type!;

      switch (type) {
        case EditType.REPLACE:
          do {
            spos++;
            dpos++;
            i--;
            o++;
          } while (i != 0 &&
              ops[o].type == type &&
              spos == ops[o].spos &&
              dpos == ops[o].dpos);
          break;

        case EditType.DELETE:
          do {
            spos++;
            i--;
            o++;
          } while (i != 0 &&
              ops[o].type == type &&
              spos == ops[o].spos &&
              dpos == ops[o].dpos);
          break;

        case EditType.INSERT:
          do {
            dpos++;
            i--;
            o++;
          } while (i != 0 &&
              ops[o].type == type &&
              spos == ops[o].spos &&
              dpos == ops[o].dpos);
          break;

        default:
          break;
      }
    }

    if (spos < len1 || dpos < len2) {
      assert(len1 - spos == len2 - dpos);

      MatchingBlock mb = new MatchingBlock();
      mb.spos = spos;
      mb.dpos = dpos;
      mb.length = len1 - spos;

      matchingBlocks[mbIndex++] = mb;
    }

    assert(numberOfMatchingBlocks == mbIndex);

    MatchingBlock finalBlock = new MatchingBlock();
    finalBlock.spos = len1;
    finalBlock.dpos = len2;
    finalBlock.length = 0;

    matchingBlocks[mbIndex] = finalBlock;

    return matchingBlocks;
  }

  // static List<OpCode> _editOpsToOpCodes(List<EditOp> ops, int len1, int len2) {
  //   int n = ops.length;
  //   int noOfBlocks, i, spos, dpos;
  //   int o = 0;
  //   EditType type;

  //   noOfBlocks = 0;
  //   spos = dpos = 0;

  //   for (i = n; i != 0;) {
  //     while (ops[o].type == EditType.KEEP && --i != 0) {
  //       o++;
  //     }

  //     if (i == 0) break;

  //     if (spos < ops[o].spos! || dpos < ops[o].dpos!) {
  //       noOfBlocks++;
  //       spos = ops[o].spos!;
  //       dpos = ops[o].dpos!;
  //     }

  //     // TODO: Is this right?
  //     noOfBlocks++;
  //     type = ops[o].type!;

  //     switch (type) {
  //       case EditType.REPLACE:
  //         do {
  //           spos++;
  //           dpos++;
  //           i--;
  //           o++;
  //         } while (i != 0 &&
  //             ops[o].type == type &&
  //             spos == ops[o].spos &&
  //             dpos == ops[o].dpos);
  //         break;

  //       case EditType.DELETE:
  //         do {
  //           spos++;
  //           i--;
  //           o++;
  //         } while (i != 0 &&
  //             ops[o].type == type &&
  //             spos == ops[o].spos &&
  //             dpos == ops[o].dpos);
  //         break;

  //       case EditType.INSERT:
  //         do {
  //           dpos++;
  //           i--;
  //           o++;
  //         } while (i != 0 &&
  //             ops[o].type == type &&
  //             spos == ops[o].spos &&
  //             dpos == ops[o].dpos);
  //         break;

  //       default:
  //         break;
  //     }
  //   }

  //   if (spos < len1 || dpos < len2) {
  //     noOfBlocks++;
  //   }

  //   List<OpCode> opCodes = List.filled(noOfBlocks, OpCode());

  //   o = 0;
  //   spos = dpos = 0;
  //   int oIndex = 0;

  //   for (i = n; i != 0;) {
  //     while (ops[o].type == EditType.KEEP && --i != 0) o++;

  //     if (i == 0) break;

  //     OpCode oc = new OpCode();
  //     opCodes[oIndex] = oc;
  //     oc.sbeg = spos;
  //     oc.dbeg = dpos;

  //     if (spos < ops[o].spos! || dpos < ops[o].dpos!) {
  //       oc.type = EditType.KEEP;
  //       spos = oc.send = ops[o].spos!;
  //       dpos = oc.dend = ops[o].dpos!;

  //       oIndex++;
  //       OpCode oc2 = new OpCode();
  //       opCodes[oIndex] = oc2;
  //       oc2.sbeg = spos;
  //       oc2.dbeg = dpos;
  //     }

  //     type = ops[o].type!;

  //     switch (type) {
  //       case EditType.REPLACE:
  //         do {
  //           spos++;
  //           dpos++;
  //           i--;
  //           o++;
  //         } while (i != 0 &&
  //             ops[o].type == type &&
  //             spos == ops[o].spos &&
  //             dpos == ops[o].dpos);
  //         break;

  //       case EditType.DELETE:
  //         do {
  //           spos++;
  //           i--;
  //           o++;
  //         } while (i != 0 &&
  //             ops[o].type == type &&
  //             spos == ops[o].spos &&
  //             dpos == ops[o].dpos);
  //         break;

  //       case EditType.INSERT:
  //         do {
  //           dpos++;
  //           i--;
  //           o++;
  //         } while (i != 0 &&
  //             ops[o].type == type &&
  //             spos == ops[o].spos &&
  //             dpos == ops[o].dpos);
  //         break;

  //       default:
  //         break;
  //     }

  //     opCodes[oIndex].type = type;
  //     opCodes[oIndex].send = spos;
  //     opCodes[oIndex].dend = dpos;
  //     oIndex++;
  //   }

  //   if (spos < len1 || dpos < len2) {
  //     assert(len1 - spos == len2 - dpos);
  //     opCodes[oIndex].type = EditType.KEEP;
  //     opCodes[oIndex].sbeg = spos;
  //     opCodes[oIndex].dbeg = dpos;
  //     opCodes[oIndex].send = len1;
  //     opCodes[oIndex].dend = len2;

  //     oIndex++;
  //   }

  //   assert(oIndex == noOfBlocks);

  //   return opCodes;
  // }

  static int levEditDistance(String s1, String s2, int xcost) {
    int i;
    int half;
    List<int> c1 = s1.runes.toList();
    List<int> c2 = s2.runes.toList();
    int str1 = 0;
    int str2 = 0;
    int len1 = s1.length;
    int len2 = s2.length;
    while (((len1 > 0) && (len2 > 0)) && (c1[str1] == c2[str2])) {
      len1--;
      len2--;
      str1++;
      str2++;
    }
    while (((len1 > 0) && (len2 > 0)) &&
        (c1[(str1 + len1) - 1] == c2[(str2 + len2) - 1])) {
      len1--;
      len2--;
    }
    if (len1 == 0) {
      return len2;
    }
    if (len2 == 0) {
      return len1;
    }
    if (len1 > len2) {
      int nx = len1;
      int temp = str1;
      len1 = len2;
      len2 = nx;
      str1 = str2;
      str2 = temp;
      List<int> t = c2;
      c2 = c1;
      c1 = t;
    }
    if (len1 == 1) {
      if (xcost != 0) {
        return (len2 + 1) - (2 * _memchr(c2, str2, c1[str1], len2));
      } else {
        return len2 - _memchr(c2, str2, c1[str1], len2);
      }
    }
    len1++;
    len2++;
    half = (len1 >> 1);
    List<int> row = List<int>.filled(len2, 0);
    int end = (len2 - 1);
    for ((i = 0); i < (len2 - ((xcost != 0) ? 0 : half)); i++) {
      row[i] = i;
    }
    if (xcost != 0) {
      for ((i = 1); i < len1; i++) {
        int p = 1;
        int ch1 = c1[(str1 + i) - 1];
        int c2p = str2;
        int D = i;
        int x = i;
        while (p <= end) {
          if (ch1 == c2[c2p++]) {
            x = (--D);
          } else {
            x++;
          }
          D = row[p];
          D++;
          if (x > D) {
            x = D;
          }
          row[p++] = x;
        }
      }
    } else {
      row[0] = ((len1 - half) - 1);
      for ((i = 1); i < len1; i++) {
        int p;
        int ch1 = c1[(str1 + i) - 1];
        int c2p;
        int D;
        int x;
        if (i >= (len1 - half)) {
          int offset = (i - (len1 - half));
          int c3;
          c2p = (str2 + offset);
          p = offset;
          c3 = (row[p++] + ((ch1 != c2[c2p++]) ? 1 : 0));
          x = row[p];
          x++;
          D = x;
          if (x > c3) {
            x = c3;
          }
          row[p++] = x;
        } else {
          p = 1;
          c2p = str2;
          D = (x = i);
        }
        if (i <= (half + 1)) {
          end = (((len2 + i) - half) - 2);
        }
        while (p <= end) {
          int c3 = ((--D) + ((ch1 != c2[c2p++]) ? 1 : 0));
          x++;
          if (x > c3) {
            x = c3;
          }
          D = row[p];
          D++;
          if (x > D) {
            x = D;
          }
          row[p++] = x;
        }
        if (i <= half) {
          int c3 = ((--D) + ((ch1 != c2[c2p]) ? 1 : 0));
          x++;
          if (x > c3) {
            x = c3;
          }
          row[p] = x;
        }
      }
    }
    i = row[end];
    return i;
  }

  static int _memchr(List<int> haystack, int offset, int needle, int num) {
    if (num != 0) {
      int p = 0;
      do {
        if (haystack[offset + p] == needle) {
          return 1;
        }
        p++;
      } while ((--num) != 0);
    }
    return 0;
  }

  static double getRatio(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    int lensum = len1 + len2;

    int editDistance = levEditDistance(s1, s2, 1);

    return (lensum - editDistance) / lensum.toDouble();
  }
}
