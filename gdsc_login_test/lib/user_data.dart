class UserData {
  String? email;
  String? name;
  String? phone;

  UserData({this.email, this.name, this.phone});

  Map<String, dynamic> toMap(){
    return{
      'email' : email,
      'name':name,
      'phone':phone,

    };
  }


}