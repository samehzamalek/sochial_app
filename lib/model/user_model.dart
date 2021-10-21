class UserModel
{
  String? name;
  String? email;
  String? uid;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    this.uid,
    this.email,
    this.phone,
    this.name,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified
});
  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    uid=json['uid'];
    phone=json['phone'];
    email=json['email'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];

  }
  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'uid':uid,
      'phone':phone,
      'email':email,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
      'image':image,
    };
  }

}