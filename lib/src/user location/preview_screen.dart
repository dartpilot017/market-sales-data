import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_provider.dart';
import 'save_confirmation_screen.dart';

class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;

  const ImagePreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final UserPictureProvider imageProvider = Provider.of<UserPictureProvider>(
        context,
        listen: false); // Access the provider

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 300,
              width: 300,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(160),
                color: const Color(0xff50b14a).withOpacity(0.84),
              ),
              child: CircleAvatar(
                radius: width * 0.9,
                backgroundImage: FileImage(imageFile),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Verified',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xff50b14a).withOpacity(0.84),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Use this photo?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.54),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(
                horizontal: 3,
                vertical: 10,
              ),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text:
                          'By tapping save, you agree that Mapper or a trusted \nvendor can collect and process your photos with \ntechnology that allows us to verify your identity.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.4),
                      ))
                ]),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, 'retake');
                  },
                  child: Container(
                    height: 46,
                    width: 135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xff50b14a).withOpacity(0.84),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 2,
                    ),
                    child: Container(
                      height: 46,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Change',
                          style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff50b14a).withOpacity(0.84),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    imageProvider.updateUserPicture(imageFile);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SaveConfirmationScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 46,
                    width: 135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xff50b14a).withOpacity(0.84),
                    ),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
