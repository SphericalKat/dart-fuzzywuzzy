import 'edit_type.dart';

class OpCode {
  EditType? type;
  int? sbeg, send;
  int? dbeg, dend;

  @override
  String toString() {
    return "$type($sbeg,$send,$dbeg,$dend)";
  }
}
