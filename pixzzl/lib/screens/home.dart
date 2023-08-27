import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pixzzl/main.dart';
import 'package:pixzzl/screens/grid.dart';
import 'package:pixzzl/screens/up_success.dart';
import 'package:pixzzl/screens/upload.dart';
import 'package:pixzzl/utils/widgets/custom_button.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:pixzzl/utils/widgets/custom_animated_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _onEditing = false;
  @override
  void initState() {
    dataController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dataController.style.white(context),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 10,
            left: 10,
          ),
          child: GNav(
            rippleColor: Colors.deepPurple,
            hoverColor: dataController.style.lavender(context).withOpacity(0.5),
            haptic: true,
            tabBorderRadius: 30,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            tabShadow: [
              BoxShadow(
                color: dataController.style.lavender(context).withOpacity(0.5),
                blurRadius: 8,
              )
            ],
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 300),
            gap: 8,
            color: dataController.style.lavender(context),
            activeColor: Colors.deepPurple,
            iconSize: 40,
            tabBackgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            selectedIndex: dataController.currentTab,
            tabs: [
              GButton(
                onPressed: () {},
                icon: Icons.get_app,
                text: 'Receive',
              ),
              GButton(
                icon: Icons.upload,
                text: 'Upload',
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.image);

                  if (result != null) {
                    dataController.currentTab = 1;

                    File file = File(result.files.single.path!);
                    if (!mounted) return;

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UploadScreen(
                            1,
                            "Uploading.....",
                            "Please wait a moment while we upload your files",
                            () async {
                          var data = await dataController.getFileURL(file);
                          Timer(
                            const Duration(seconds: 2),
                            () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UploadSuccess(
                                    data["url"],
                                    const HomePage(),
                                  ),
                                ),
                              );
                              dataController.currentTab = 0;
                            },
                          );
                        }),
                      ),
                    );
                  } else {
                    dataController.currentTab = 0;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: VerificationCode(
                textStyle:
                    const TextStyle(fontSize: 35.0, color: Colors.deepPurple),
                keyboardType: TextInputType.text,
                underlineColor: dataController.style.lavender(context),
                length: 5,
                cursorColor: dataController.style.lavender(context),
                clearAll: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    primaryColor: const Color(0xff4338CA),
                    text: "Clear All",
                    onPressed: () {},
                  ),
                ),
                onCompleted: (String value) async {
                  setState(() {
                    dataController.code = value;
                  });
                  var data = await dataController
                      .getImageFromCode(dataController.code);

                  if (!mounted) return;
                  //sZmHV
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => PuzzlePage(
                        urls: List<String>.from(data["urls"]),
                        url: data["url"],
                      ),
                    ),
                  );
                },
                onEditing: (bool value) {
                  setState(() {
                    _onEditing = value;
                  });
                  if (!_onEditing) FocusScope.of(context).unfocus();
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomAnimatedButton(
                onTap: () {},
                color: Colors.deepPurple,
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
