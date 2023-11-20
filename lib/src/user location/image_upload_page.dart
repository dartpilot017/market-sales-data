import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'camera_screen.dart';
import 'image_provider.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final userPictureProvider = context.watch<UserPictureProvider>();
    final userPicture = userPictureProvider.userPicture;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 25,
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.08,
            ),
            if (userPicture != null)
              CircleAvatar(
                radius: width * 0.36,
                backgroundImage: FileImage(userPicture),
              )
            else
              CircleAvatar(
                radius: width * 0.36,
                backgroundImage: const NetworkImage(
                    'https://moorepediatricnc.com/wp-content/uploads/2022/08/default_avatar.jpg'),
              ),
            SizedBox(
              height: height * 0.036,
            ),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        '1. Face the camera and make sure your\n    eyes and mouth are clearly visible.\n2. Make sure the photo is well fit, free of\n    glare and in focus.\n3. No photo of a photo, filters or\n    alterations.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xffACA8AC),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: cameraSwitch(),
            ),
          ],
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    // Check and request camera permission here.
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } else {
      // Handle permission denied or restricted case.
      // You can show a dialog or message to inform the user.
    }
  }

  GestureDetector cameraSwitch() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraScreen(initialImageFile: _imageFile),
          ),
        ).then((newImageFile) {
          // Handle the returned image file here if needed.
          if (newImageFile != null) {
            setState(() {
              _imageFile = newImageFile;
            });
          }
        });
      },
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff50B14A).withOpacity(0.9),
        ),
        child: const Center(
          child: Text(
            'Camera',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
