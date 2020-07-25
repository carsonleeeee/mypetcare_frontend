import 'profileList.dart';

class User {  
  String id,username,email,password;
  ProfileList profile;

  User(this.id,this.username,this.email,this.password,this.profile);
  User.copy(User from): this(from.id,from.username,from.email,from.password,from.profile);

  User.fromJson(Map<String, dynamic> json)
      : this(
            json['id'],json['username'], json['email'], json['password'], ProfileList.fromJson(json['profile']));

  Map<String, dynamic> toJson() =>
      {'id': id, 'username': username, 'email': email, 'password': password, 'profile': profile};
}