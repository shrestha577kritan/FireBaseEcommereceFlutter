import 'package:hive/hive.dart';
part 'user.g.dart';


// run this command for crating adaptor 
// flutter pub run build_runner build --delete-conflicting-outputs
// flutter pub run build_runner build


@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String token;

  @HiveField(3)
  String id;

  User({
    required this.username,
    required this.email,
    required this.token,
    required this.id,
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'],
        token: json['token'],
        id: json['id']);
  }
  
  
}
