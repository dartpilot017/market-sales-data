// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skyhigh_app/src/user%20location/image_provider.dart';
import 'preview_screen.dart';

class CameraScreen extends StatefulWidget {
  final XFile? initialImageFile;

  const CameraScreen({Key? key, this.initialImageFile}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    _cameraController = CameraController(
      const CameraDescription(
        name: '1',
        sensorOrientation: 90,
        lensDirection: CameraLensDirection.back,
      ),
      ResolutionPreset.medium,
    );

    _initializeCamera();

    if (widget.initialImageFile != null) {}
  }

  Future<void> _initializeCamera() async {
    await _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 12,
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.18),
            Center(
              child: ClipOval(
                child: Container(
                  width: width * 0.88,
                  height: height * 0.38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(160),
                  ),
                  child: CameraPreview(_cameraController),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Verifying...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: height * 0.22),
            GestureDetector(
                onTap: _captureImage,
                child: CircleAvatar(
                  radius: width * 0.09,
                  backgroundColor: const Color(0xff50b14a).withOpacity(0.84),
                  child: CircleAvatar(
                    radius: width * 0.075,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: width * 0.05,
                      backgroundColor:
                          const Color(0xff50b14a).withOpacity(0.84),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _captureImage() async {
    if (!_cameraController.value.isTakingPicture) {
      try {
        final imageFile = await _cameraController.takePicture();

        // Update the user picture in the state management solution.
        context
            .read<UserPictureProvider>()
            .updateUserPicture(File(imageFile.path));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ImagePreviewScreen(imageFile: File(imageFile.path)),
          ),
        );
      } catch (e) {
        //
      }
    }
  }
}
