import 'profileList.dart';

class UserList {
  String username,email,password;
  ProfileList profileList;

  UserList(this.username,this.email,this.password,this.profileList);
  UserList.copy(UserList from): this(from.username,from.email,from.password,from.profileList);
}