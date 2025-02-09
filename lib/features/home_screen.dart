import 'package:deepfake/common/upload_button.dart';
import 'package:deepfake/features/analyzing_provider.dart';
import 'package:deepfake/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<AnalyzingProvider>(
        builder: (context, provider, child) {

          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height * 0.4;
          double aspectRatio = screenWidth / screenHeight;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/intro_icon.png', width: 150, height: 150, fit: BoxFit.cover),
                  UploadButton(onPressed: () => provider.pickVideo()),
                  const SizedBox(height: 10),
                  if (provider.isVideoSelected && provider.controller != null) ...[
                    Text(
                      'VIDEO UPLOADED:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.instance.white.withAlpha(400),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: provider.togglePlayPause,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: aspectRatio,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: VideoPlayer(provider.controller!),
                            ),
                          ),
                          if (!provider.controller!.value.isPlaying)
                            const Icon(Icons.play_arrow, size: 50, color: Colors.white),
                          // Close "X" button
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: provider.deselectVideo,
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    VideoProgressIndicator(
                      provider.controller!,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.red,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Dropdown Selection
                    Container(
                      height: 48.0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: AppColors.instance.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: PopupMenuButton<String>(
                        onSelected: provider.setSelectedAction,
                        color: AppColors.instance.white,
                        itemBuilder: (context) => [
                          _buildPopupMenuItem("Presenting", Icons.present_to_all),
                          _buildPopupMenuItem("Reading", Icons.menu_book),
                          _buildPopupMenuItem("Watching", Icons.remove_red_eye),
                        ],
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                        ),
                        offset: const Offset(-10, 44),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                provider.selectedAction ?? "What action is the person doing?",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.instance.black.withAlpha(90),
                                ),
                              ),
                            ),
                            const Icon(Icons.menu, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper method to create a popup menu item
  PopupMenuItem<String> _buildPopupMenuItem(String value, IconData icon) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
