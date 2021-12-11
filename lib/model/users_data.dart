enum UserType{
  invitado,
  usuario
}

List<UserType> getStoreTypes(){
  return UserType.values;
}

class Users {
  int id;
  String name;
  String address;
  String phone;
  String cellphone;
  String password='0';
  UserType type;


  Users(this.id, this.name, this.address, this.phone, this.cellphone,
      this.password, this.type);

  Users.formJson(Map<String, dynamic> json)
      : id = int.parse(json['ID'].toString()),
        name = json['name'].toString(),
        address = json['address'].toString(),
        phone = json['phone'].toString(),
        cellphone = json['cellphone'].toString(),
        password = json['pass'].toString(),
        type = UserType.values.firstWhere((element) =>
        element.toString() == 'UserType.' + json['type'].toString());
}