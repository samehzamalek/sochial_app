class PostModel {
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;


  PostModel({this.uid, this.name, this.image,this.dateTime,this.text,this.postImage});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];


  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
