import 'package:flutter/material.dart';
import 'package:skyhigh_app/src/main_screen.dart';

class SaveConfirmationScreen extends StatelessWidget {
  const SaveConfirmationScreen({super.key});

  // Method to navigate to the home screen
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 350,
            ),
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Photo Uploaded Successfully!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 170,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  _navigateToHome(context); // Call the navigate method
                },
                child: Container(
                  height: 46,
                  width: double.maxFinite,
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
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: const Color(0xff50b14a).withOpacity(0.84),
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                                fontSize: 15,
                                color:
                                    const Color(0xff50b14a).withOpacity(0.84),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
