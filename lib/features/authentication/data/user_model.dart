// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? name;
  String? email;
  String? image;
  String? uid;
   bool? isVerified;
  UserModel({
    this.name,
    this.email,
    this.image,
    this.uid,
    this.isVerified
  });
   @override toString() { return 'User: name $name email $email image $image  isVerified $isVerified uid $uid' ;}
  UserModel.FromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
   image = json['image'];
    uid = json['uid'];
        isVerified = json['isVerified'];

  }

  Map<String, dynamic> ToMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'uid': uid,
      'isVerified' :isVerified
    };
  }
}
