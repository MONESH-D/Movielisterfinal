import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:movie_app/main.dart';

import 'package:movie_app/views/movie.dart';
import 'package:google_fonts/google_fonts.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  _SigninpageState createState() => _SigninpageState();
}

var user = FirebaseAuth.instance.currentUser;
var signstatus;

class _SigninpageState extends State<Signinpage> {
  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    print(user);
    super.initState();

    // Timer(Duration(seconds: 1), () {
    //   setState(() {
    //     //   // final user = FirebaseAuth.instance.currentUser;
    //   });
    // });
  }

  Widget movieposters(num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        height: 350,
        child: Image(
          image: AssetImage("assets/$num.jpg"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null
        ? MvoiesPage()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 100,
                            child: SizedBox(
                              width: 280.0,
                              child: DefaultTextStyle(
                                style: GoogleFonts.notoSans(
                                    color: Colors.black, fontSize: 25),
                                child: AnimatedTextKit(
                                  totalRepeatCount: 2,
                                  animatedTexts: [
                                    TypewriterAnimatedText('Hello....',
                                        speed: Duration(milliseconds: 40)),
                                    TypewriterAnimatedText(
                                        'Welcome! to Movie Lister',
                                        speed: Duration(milliseconds: 40)),
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                              ),
                            ),
                          ),
                          CarouselSlider(
                              items: [
                                movieposters(1),
                                movieposters(2),
                                movieposters(3),
                                movieposters(4),
                                movieposters(5)
                              ],
                              options: CarouselOptions(
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              )),
                          Container(
                              width: 280,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image:
                                            AssetImage("assets/checkfinal.png"),
                                        width: 20,
                                      ),
                                      Center(
                                          child: Text(
                                              "Create List of Movies You Watched")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage("assets/edif.png"),
                                        width: 22,
                                      ),
                                      Center(child: Text("Edit the List")),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage("assets/delete.png"),
                                        width: 20,
                                      ),
                                      Center(
                                          child: Text(
                                              "Delete a movie from the list")),
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            child: GestureDetector(
                                onTap: () {
                                  signInWithGoogle();

                                  print(FirebaseAuth.instance.currentUser);

                                  // Timer(Duration(seconds: 1), () {
                                  //   setState(() {
                                  //     //   // final user = FirebaseAuth.instance.currentUser;
                                  //   });
                                  // });
                                  signstatus = 1;

                                  setState(() {});
                                },
                                child: Center(
                                  child: Material(
                                    elevation: 20,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: signstatus != 1
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                      width: 40,
                                                      height: 40,
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/Google.png"))),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: Center(
                                                          child: Text(
                                                              "Sign in with Google"))),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                ],
                                              )
                                            : Center(
                                                child: Text("Confirm Signin"))),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
