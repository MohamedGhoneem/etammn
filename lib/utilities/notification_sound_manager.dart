// // notification_sound_manager.dart
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:audioplayers/audioplayers.dart';
//
// class NotificationSoundManager {
//   static final NotificationSoundManager _instance = NotificationSoundManager._internal();
//   factory NotificationSoundManager() => _instance;
//   NotificationSoundManager._internal();
//
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final Map<String, String> _soundUrls = {
//     'fire': 'assets/sounds/fire.wav',
//     'warning': 'assets/sounds/warning.wav',
//   };
//
//   Map<String, String> _localSoundPaths = {};
//   bool _isInitialized = false;
//
//   Future<void> initialize() async {
//     if (_isInitialized) return;
//
//     try {
//       await _downloadAndStoreSounds();
//       _isInitialized = true;
//     } catch (e) {
//       print('Failed to initialize notification sounds: $e');
//     }
//   }
//
//   Future<void> _downloadAndStoreSounds() async {
//     final directory = await getApplicationDocumentsDirectory();
//
//     for (var entry in _soundUrls.entries) {
//       final soundType = entry.key;
//       final soundUrl = entry.value;
//       final localPath = '${directory.path}/$soundType.wav';
//       final file = File(localPath);
//
//       // Download file if it doesn't exist
//       if (!await file.exists()) {
//         try {
//           final response = await http.get(Uri.parse(soundUrl));
//           await file.writeAsBytes(response.bodyBytes);
//         } catch (e) {
//           print('Failed to download $soundType sound: $e');
//           continue;
//         }
//       }
//
//       _localSoundPaths[soundType] = localPath;
//     }
//   }
//
//   Future<void> playSound(String soundType) async {
//     if (!_isInitialized) {
//       print('NotificationSoundManager not initialized');
//       return;
//     }
//
//     final soundPath = _localSoundPaths[soundType];
//     if (soundPath == null) {
//       print('Sound not found for type: $soundType');
//       return;
//     }
//
//     try {
//       await _audioPlayer.stop(); // Stop any currently playing sound
//       await _audioPlayer.play(DeviceFileSource(soundPath));
//     } catch (e) {
//       print('Failed to play $soundType sound: $e');
//     }
//   }
//
//   Future<void> stopSound() async {
//     try {
//       await _audioPlayer.stop();
//     } catch (e) {
//       print('Failed to stop sound: $e');
//     }
//   }
//
//   void dispose() {
//     _audioPlayer.dispose();
//   }
// }