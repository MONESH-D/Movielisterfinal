import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/adaptors/movie_adapter.dart';
import 'package:image_picker/image_picker.dart';

ImagePicker picker = ImagePicker();

class AddMovies extends StatefulWidget {
  final formkey = GlobalKey<FormState>();

  @override
  _AddMoviesState createState() => _AddMoviesState();
}

final ImagePicker _picker = ImagePicker();

class _AddMoviesState extends State<AddMovies> {
  var director;
  var name;
  XFile? _image;
  File? finalfile;
  var paths;
  _imgfromgallary() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    print(image);

    setState(() {
      _image = image;
      finalfile = File(_image!.path);
    });
  }

  var X;
  submitData() async {
    if (name != null && _image!.path != null) {
      Box<Movie> movie = Hive.box<Movie>('movies');
      movie.add(Movie(name: name, director: director, imagepath: _image!.path));
      Navigator.of(context).pop();
    } else {
      X = 1;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Movies"),
        backgroundColor: Color(0xFF8CE5C3),
      ),
      body: Form(
        key: widget.formkey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Movie Name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Director Name'),
                onChanged: (value) {
                  setState(() {
                    director = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: () {
                  _imgfromgallary();
                },
                child: _image != null
                    ? Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            child: Image.file(
                          File(finalfile!.path),
                          width: 200,
                          height: 200,
                        )),
                      )
                    : Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Add Image"),
                            ],
                          )),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                  onTap: submitData,
                  child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color(0xFF82d9e3),
                                Color(0xFFa5e7cc)
                              ])),
                          height: 50,
                          child: Center(child: Text("Submit"))))),
            ),
            X != null
                ? Container(
                    child: Center(
                        child: Text(
                            "Please Give Movie and Director Name with Poster Image")),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
