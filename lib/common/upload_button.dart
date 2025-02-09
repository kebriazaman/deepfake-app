import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16),
        textStyle: TextStyle(fontSize: 16),
        shape: StadiumBorder(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Upload Video', style: Theme.of(context).textTheme.bodyLarge), // Button text
          Icon(Icons.cloud_upload, size: 30.0), // Upload icon
        ],
      ),
    );
  }
}