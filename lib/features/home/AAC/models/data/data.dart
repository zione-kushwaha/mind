// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'jsonString.dart';

// Default home board that users first see when logged in
Map<String, FolderModel> defaultBoards = getData(jsonString).folders ?? {};

// Transfer JSON data to Dart objects
Data getData(String str) => Data.fromJson(json.decode(str));

// Transfer Dart objects to JSON string for uploading to the database
String postToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({this.beginner, this.folders});

  List<dynamic>? beginner;
  Map<String, FolderModel>? folders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    beginner: json["beginner"] as List<dynamic>? ?? [],
    folders:
        (json["advanced"] as List<dynamic>?)
            ?.map<FolderModel>((x) => FolderModel.fromJson(x))
            .toList()
            .asMap()
            .map((_, folder) => MapEntry(folder.id, folder)) ??
        {}, // Provide an empty map if null
  );

  Map<String, dynamic> toJson() => {
    "beginner": beginner,
    "advanced": folders?.values.map((x) => x.toJson()).toList(),
  };
}

class FolderModel {
  FolderModel({
    required this.id,
    required this.name,
    required this.nameKey,
    required this.author,
    required this.isPublic,
    required this.hidden,
    required this.subItems,
    required this.caption,
  });

  String id;
  String name;
  String nameKey;
  Author author;
  bool isPublic;
  bool hidden;
  List<TileModel> subItems;
  String caption;

  factory FolderModel.fromJson(Map<String, dynamic> json) => FolderModel(
    id: json["id"] ?? "",
    name: json["name"] ?? "Unnamed Folder",
    nameKey: json["nameKey"] ?? "",
    isPublic: json["isPublic"] ?? false,
    hidden: json["hidden"] ?? false,
    subItems:
        (json["tiles"] as List<dynamic>?)
            ?.map<TileModel>((x) => TileModel.fromJson(x))
            .toList() ??
        [], // Provide an empty list if null
    caption: json["caption"] ?? "",
    author: authorValues.map[json["author"]] ?? Author.CBOARD,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "nameKey": nameKey,
    "isPublic": isPublic,
    "hidden": hidden,
    "tiles": subItems.map((x) => x.toJson()).toList(),
    "caption": caption,
  };
}

enum Author { CBOARD }

final authorValues = EnumValues({"Cboard": Author.CBOARD});

class TileModel {
  TileModel({
    required this.labelKey,
    this.image,
    required this.id,
    this.backgroundColor,
    this.loadBoard,
  });

  String labelKey;
  String? image;
  String id;
  Color? backgroundColor;
  String? loadBoard;

  factory TileModel.fromJson(Map<String, dynamic> json) => TileModel(
    labelKey: json["labelKey"] ?? "",
    image: json["image"],
    id: json["id"] ?? "",
    backgroundColor:
        backgroundColorValues.map[json["backgroundColor"]] ??
        Colors.transparent,
    loadBoard: json["loadBoard"],
  );

  Map<String, dynamic> toJson() => {
    "labelKey": labelKey,
    "image": image,
    "id": id,
    "backgroundColor": backgroundColorValues.reverse[backgroundColor],
    "loadBoard": loadBoard,
  };
}

// Background color values, different between Cboard mobile and web
enum BackgroundColor { RGB_255241118, RGB_187222251 }

final backgroundColorValues = EnumValues({
  "rgb(187, 222, 251)": Color(0xFFBBDEFB), // Light blue
  "rgb(255, 241, 118)": Color(0xFFFFF176), // Light yellow
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
