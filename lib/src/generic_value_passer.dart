part of basic_core;

class GenericValuePasser {
  String valueString;
  Object valueObject;
  List<Object> valueObjectList;
  bool valueBool;

  GenericValuePasser(
      {String valueString,
      Object valueObject,
      List<Object> valueObjectList,
      bool valueBool}) {
    this.valueString = valueString;
    this.valueBool = valueBool;
    this.valueObject = valueObject;
    this.valueObjectList = valueObjectList;
  }
  String get getString => valueString;
  bool get getBool => valueBool;
  Object get getObject => valueObject;
  List<Object> get getObjectList => valueObjectList;
}
