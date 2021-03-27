import 'edit_type.dart';

class EditOp {
  EditType? type;
  int? spos; // source block pos
  int? dpos; // destination block pos

  @override
  String toString() {
    return "$type($spos,$dpos)";
  }
}
