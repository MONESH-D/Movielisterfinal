import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8CE5C3),
        title: Text("Profile"),
      ),
      body: Container(
          child: Center(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 300,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("${user!.photoURL}")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 40),
                  child: Text("Name: ${user!.displayName!}"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 20),
                  child: Text("Email: ${user!.email!}"),
                ),
                // Text("Name: ${user.}"),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
