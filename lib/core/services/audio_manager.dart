import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:linkai/core/services/file_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioManager {
  AudioManager(this._fileName, this._codec);

  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  final Codec _codec;
  final int _sampleRate = 16000;
  final FileManager _fileManager = const FileManager();
  final String _fileName;

  Future<String> startRecording() async {
    await _audioRecorder.openRecorder();
    final PermissionStatus permissionStatus = await Permission.microphone.request();

    if (permissionStatus.isGranted) {
      debugPrint("Start Recording");
      final String path = await _fileManager.getFullFilePath(_fileName);
      debugPrint("audio_file_path: $path");

      await _audioRecorder.startRecorder(
        codec: _codec,
        sampleRate: _sampleRate,
        toFile: path,
      );

      return path;
    } else {
      throw Exception("Permission Denied");
    }
  }

  Future<String> stopRecording() async {
    debugPrint("Stop Recording");
    String? path = await _audioRecorder.stopRecorder();
    await _audioRecorder.closeRecorder();
    debugPrint(path!);
    return path;
  }

  Future<void> startPlayAudio() async {
    _audioPlayer = (await _audioPlayer.openPlayer())!;

    await _audioPlayer.startPlayer(
      fromURI: await _fileManager.getFullFilePath(_fileName),
      codec: _codec,
      whenFinished: () async {},
    );

    debugPrint("Start Play Audio");
  }

  Future<void> stopPlayAudio() async {
    await _audioPlayer.stopPlayer();
    debugPrint("Stop Play Audio");
  }
}
