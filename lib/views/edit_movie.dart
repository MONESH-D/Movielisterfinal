import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/adaptors/movie_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class EditMovie extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  EditMovie(
      {required this.director,
      required this.imagepath,
      required this.name,
      required this.box,
      required this.index});
  final name;
  final director;
  final imagepath;
  final index;
  final Box<Movie> box;
  @override
  _EditMovieState createState() => _EditMovieState(
      box: box,
      director: director,
      name: name,
      imagepath: imagepath,
      index: index);
}

final ImagePicker _picker = ImagePicker();

class _EditMovieState extends State<EditMovie> {
  XFile? _image;
  File? finalfile;
  var paths;
  _EditMovieState(
      {required this.director,
      required this.imagepath,
      required this.name,
      required this.index,
      required this.box});
  final name;
  final director;
  final imagepath;
  final index;
  final Box<Movie> box;
  String? editedname;
  String? editeddirector;
  String? editedimagepath;
  _imgfromgallary() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    print(image);

    setState(() {
      _image = image;
      finalfile = File(_image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Movie"),
        backgroundColor: Color(0xFF8CE5C3),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Current Data",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Center(
                          child: Image.file(
                            File(imagepath),
                            width: 100,
                            height: 200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 0, left: 10),
                          child: Text("Movie Name: $name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 10, left: 10),
                          child: Text("Director: $director"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Form(
                    key: widget.formkey,
                    child: Column(
                      // shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.greenAccent),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Movie Name'),
                              onChanged: (value) {
                                setState(() {
                                  editedname = value;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.greenAccent),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Movie Name'),
                              onChanged: (value) {
                                setState(() {
                                  editeddirector = value;
                                });
                              }),
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
                                    child: Container(
                                        child: Image.file(
                                      File(finalfile!.path),
                                      width: 100,
                                      height: 100,
                                    )),
                                  )
                                : Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 50,
                                      child: Center(child: Text("Add Image")),
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GestureDetector(
                              onTap: () {
                                editeddirector == null
                                    ? editeddirector = director
                                    : editeddirector = editeddirector;
                                editedname == null
                                    ? editedname = name
                                    : editedname = editedname;
                                finalfile == null
                                    ? editedimagepath = imagepath
                                    : editedimagepath = _image!.path;
                                if (editeddirector != null &&
                                    imagepath != null &&
                                    editedname != null) {
                                  box.putAt(
                                      index,
                                      Movie(
                                          director: editeddirector,
                                          imagepath: editedimagepath,
                                          name: editedname));
                                }
                                Navigator.pop(context);
                                // SnackBar(
                                // content: Text("Data Updated"),
                                // );
                              },
                              child: Material(
                                  elevation: 20,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      height: 50,
                                      child: Center(child: Text("Submit"))))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
