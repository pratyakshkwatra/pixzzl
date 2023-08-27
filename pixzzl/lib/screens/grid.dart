import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pixzzl/screens/home.dart';
import 'package:pixzzl/screens/up_success.dart';
import 'package:pixzzl/screens/upload.dart';
import 'package:pixzzl/utils/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../main.dart';

class PuzzlePage extends StatefulWidget {
  final List<String> urls;
  final String url;
  const PuzzlePage({Key? key, required this.urls, required this.url})
      : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

List<Map<String, int>> loc = [];

class _PuzzlePageState extends State<PuzzlePage> {
  List<String> shuffledUrls = [];
  List<int> loc = [];

  @override
  void initState() {
    super.initState();

    shuffledUrls = List.from(widget.urls);
    shuffledUrls.shuffle();

    for (int i = 0; i < shuffledUrls.length; i++) {
      loc.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dataController.style.white(context),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              ),
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
                          },
                        ),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: shuffledUrls.length,
                  itemBuilder: (context, index) {
                    return Draggable<String>(
                      key: ValueKey(shuffledUrls[
                          index]), // Add a key for correct identification
                      data: shuffledUrls[index],
                      feedback: Image.network(shuffledUrls[index]),
                      child: DragTarget<String>(
                        onAccept: (data) {
                          setState(() {
                            final int targetIndex = shuffledUrls.indexOf(data);
                            final int currentIndex =
                                shuffledUrls.indexOf(shuffledUrls[index]);

                            shuffledUrls[targetIndex] = shuffledUrls[index];
                            shuffledUrls[index] = data;

                            // Update loc indices only if they are swapped
                            if (shuffledUrls[index] ==
                                    widget.urls[currentIndex] &&
                                shuffledUrls[targetIndex] ==
                                    widget.urls[targetIndex]) {
                              loc[currentIndex] = targetIndex;
                              loc[targetIndex] = currentIndex;
                            }
                          });
                        },
                        onMove: (details) {},
                        builder: (context, candidateData, rejectedData) {
                          return Image.network(shuffledUrls[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
              if (loc.every((element) =>
                  element == shuffledUrls.indexOf(widget.urls[element])))
                const SizedBox(
                  height: 15.0,
                ),
              if (loc.every((element) =>
                  element == shuffledUrls.indexOf(widget.urls[element])))
                const Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(
                    "Congratulations, Puzzle Mastered!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.5,
                    ),
                  ),
                ),
              if (loc.every((element) =>
                  element == shuffledUrls.indexOf(widget.urls[element])))
                const SizedBox(
                  height: 15.0,
                ),
              if (loc.every((element) =>
                  element == shuffledUrls.indexOf(widget.urls[element])))
                CustomButton(
                    text: "Download Image",
                    onPressed: () {
                      launchUrlString(widget.url);
                    },
                    primaryColor: Colors.deepPurple),
            ],
          ),
        ),
      ),
    );
  }
}
