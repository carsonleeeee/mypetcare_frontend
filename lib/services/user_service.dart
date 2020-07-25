import 'package:mypetcare_userprofile/services/data_service.dart';
import 'package:mypetcare_userprofile/models/userList.dart';
import 'package:mypetcare_userprofile/models/profileList.dart';

class UserDataService {
  static final UserDataService _instance = UserDataService._constructor();
  factory UserDataService() {
    return _instance;
  }

  UserDataService._constructor();
  final rest = RestService();

  Future<List<User>> getUserList() async {
    final listJson = await rest.get('userList');

    return (listJson as List)
        .map((itemJson) => User.fromJson(itemJson))
        .toList();
  }

  Future<User> updateProfileList({String id, ProfileList profile}) async {
    final json = await rest.patch('userList/$id', data: {'profile': profile});
    return User.fromJson(json);
  }

  Future<User> createUser({User user}) async {
    final json = await rest.post('userList', data: user);
    return User.fromJson(json);
  }
}