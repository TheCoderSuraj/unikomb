import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../widgets/screen_page_setup.dart';

class ErrorScreen extends StatelessWidget {
  static const id = "ErrorScreenId";
  const ErrorScreen({
    super.key,
    this.message,
  });
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ScreenPageSetup(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          const Center(
            child: Text(
              "Error Occurred",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "${message ?? "Unknown Error"}\n\nPlease try again...\nThanks :)",
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
