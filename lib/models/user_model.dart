class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;

  UserModel({this.name, this.email, this.phone, this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}