import 'package:deepfake/resources/routes/route_names.dart';
import 'package:flutter/material.dart';

class DeepfakeVideoScreen extends StatelessWidget {
  const DeepfakeVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/deep_fake_icon.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
