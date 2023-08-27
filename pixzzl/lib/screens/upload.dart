import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class UploadScreen extends StatefulWidget {
  final int index;
  final String title;
  final String subtitle;
  final Function onInit;

  const UploadScreen(
    this.index,
    this.title,
    this.subtitle,
    this.onInit, {
    super.key,
  });

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  String tit = 'Uploading.....';

  String sub = 'Please wait a moment while we upload your files';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dataController.style.white(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.6,
            width: MediaQuery.of(context).size.height,
            child: Lottie.asset("assets/upload.json"),
          ),
          const SizedBox(
            height: 60.0,
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.5,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.5,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
