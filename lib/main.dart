import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
runApp(
MaterialApp(
home: MyApp(),
),
);
}
class MyApp extends StatelessWidget {
Future<List<User>> fetchUsers() async {
final response =
await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
if (response.statusCode == 200) {
final List<dynamic> data = json.decode(response.body)['data'];
return data.map((user) => User.fromJson(user)).toList();
} else {
throw Exception('Failed to load users');
}
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('User List'),
),
body: FutureBuilder<List<User>>(
future: fetchUsers(),
builder: (context, snapshot) {
final users = snapshot.data!;
return ListView.builder(
itemCount: users.length,
itemBuilder: (context, index) {
final user = users[index];
return ListTile(
title: Text(user.firstName),
subtitle: Text(user.email),
);
},
);
},
),
);
}
}
class User {
final String firstName;
final String email;
User({required this.firstName, required this.email});
factory User.fromJson(Map<String, dynamic> json) {
return User(
firstName: json['first_name'],
email: json['email'],
);
}
}
