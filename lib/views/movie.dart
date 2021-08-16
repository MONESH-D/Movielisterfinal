import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/adaptors/movie_adapter.dart';
import 'package:movie_app/views/add_movies.dart';
import 'dart:io';
import 'package:movie_app/views/edit_movie.dart';
import 'package:movie_app/views/profile.dart';

class MvoiesPage extends StatefulWidget {
  @override
  _MvoiesPageState createState() => _MvoiesPageState();
}

class _MvoiesPageState extends State<MvoiesPage> {
  String? showtext = "Searching";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF8CE5C3),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMovies()));
        },
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            height: 50,
            color: Color(0xFF8CE5C3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Movie Lister",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.account_circle),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Movie>('movies').listenable(),
        builder: (context, Box<Movie> box, _) {
          // List<int> keys = box.keys.cast<int>().toList();
          if (box.values.isEmpty) {
            return Center(
              child: Text("You Didn't Add Any Movie to the List"),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                    itemCount: box.length,
                    reverse: true,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      // final int key = keys[index];
                      Movie? movie = box.getAt(index);
                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                          child: Material(
                            elevation: 20,
                            borderRadius: BorderRadius.circular(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: movie!.imagepath != null
                                          ? Image.file(
                                              File(movie.imagepath!),
                                            )
                                          : Image.file(File(movie.imagepath!))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        movie.name!,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "By ${movie.director!}",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditMovie(
                                                    box: box,
                                                    director: movie.director,
                                                    imagepath: movie.imagepath,
                                                    name: movie.name,
                                                    index: index)));
                                        // box.putAt(
                                        //     index,
                                        //     Movie(
                                        //         director: "Test",
                                        //         imagepath: movie.imagepath,
                                        //         name: "edited"));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              box.deleteAt(index);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 18.0),
                                              child: Icon(Icons.delete),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
