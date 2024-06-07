import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? name;
  String? uid;
  String? image;
  String? email;
  String? twitter;
  String? youtube;
  String? instagram;
  String? facebook;

  User({
    this.email,
    this.name,
    this.uid,
    this.image,
    this.twitter,
    this.youtube,
    this.facebook,
    this.instagram
});

  Map<String,dynamic> toJson()=>{
    "name":name,
    "uid":uid,
    "image":image,
    "email":email,
    "twitter":twitter,
    "youtube":youtube,
    "instagram":instagram,
    "facebook":facebook
  };
  static User fromSnap(DocumentSnapshot snapshot){
   var dataSnapshot =  snapshot.data() as Map<String,dynamic>;

   return User(
     name: dataSnapshot["name"],
     email: dataSnapshot["email"],
     uid: dataSnapshot["uid"],
     image: dataSnapshot["image"],
     twitter: dataSnapshot["twitter"],
     facebook: dataSnapshot["facebook"],
     instagram: dataSnapshot["instagram"],
     youtube: dataSnapshot["youtube"],
    // name: dataSnapshot["name"],
   );
  }
}