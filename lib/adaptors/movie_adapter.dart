import 'dart:io';

import 'package:hive/hive.dart';
part 'movie_adapter.g.dart';

@HiveType(typeId: 1)
class Movie {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? director;
  @HiveField(3)
  String? imagepath;
  Movie({required this.name, required this.director, required this.imagepath});
}
