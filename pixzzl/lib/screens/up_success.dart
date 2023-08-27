import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pixzzl/utils/widgets/custom_button.dart';
import 'package:share_plus/share_plus.dart';
import '../main.dart';

class UploadSuccess extends StatefulWidget {
  final String imageUrl;
  final Widget toPage;

  const UploadSuccess(
    this.imageUrl,
    this.toPage, {
    Key? key,
  }) : super(key: key);

  @override
  State<UploadSuccess> createState() => _UploadSuccessState();
}

class _UploadSuccessState extends State<UploadSuccess> {
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    if (!mounted) return;
    Timer(
      const Duration(seconds: 120),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => widget.toPage,
          ),
        );
      },
    );
    super.initState();
  }

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
            child: Lottie.asset(
              "assets/success.json",
              repeat: true,
            ),
          ),
          const SizedBox(
            height: 60.0,
          ),
          const Text(
            "Image Uploaded",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.5,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Text(
              "Prepare to playfully irritate your friends like never before!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.5,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              enabled: false,
              controller: otpController,
              maxLength: 5,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: "Access Code: ${dataController.code}",
                counterText: '',
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomButton(
              primaryColor: const Color(0xff4338CA),
              text: "Continue",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => widget.toPage,
                  ),
                );
              }),
          CustomButton(
              primaryColor: Colors.greenAccent.shade700,
              text: "Share",
              onPressed: () {
                Share.share(
                    "Yo! Checkout my image on the pixzzl app using this access code: ${dataController.code}");
              })
        ],
      ),
    );
  }
}
