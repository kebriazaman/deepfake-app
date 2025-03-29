import 'package:flutter/material.dart';

class NormalVideoScreen extends StatelessWidget {
  const NormalVideoScreen({super.key});

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
            'assets/images/normal_icon.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
