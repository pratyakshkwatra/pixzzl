import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants/const.dart';
import '../constants/style.dart';

class DataController {
  final consts = Consts();
  final style = Style();
  final storage = FirebaseStorage.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference docs = FirebaseFirestore.instance.collection('docs');
  final dio = Dio();
  String code = "";
  int currentTab = 0;

  init() {}

  String getRandomString(int length) {
    const characters =
        '+-*=?AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  Future<String> uploadImageToDefaultBucket(
      File file, String randomString) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref("media").child(randomString);
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  getHttp(String url, params) async {
    final response = await dio.get(url, data: params);
    return response;
  }

  getFileURL(File file) async {
    String random = getRandomString(5);
    code = random;
    String fileUrl = await uploadImageToDefaultBucket(file, random);
    var response =
        await getHttp("http://127.0.0.1:5000/image/crop?code=$random&tiles=3", {
      "url": fileUrl,
    });
    response = json.decode(response.toString());

    List urls = response["urls"];

    docs.doc(random).set(
      {
        "path": fileUrl,
        "url": fileUrl,
        "code": random,
        "urls": urls,
      },
    );
    return {
      "code": random,
      "url": fileUrl,
    };
  }

  getImageFromCode(String code) async {
    CollectionReference data = FirebaseFirestore.instance.collection("docs");
    var response = await data.doc(code).get();
    return response.data();
  }
}
