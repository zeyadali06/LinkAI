import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioManager {
  AudioManager();

  late final FlutterSoundRecorder audioRecorder;
  late final FlutterSoundPlayer audioPlayer;
  late Codec codec;
  late String fileName;
  late int sampleRate;

  Future<void> init() async {
    audioRecorder = FlutterSoundRecorder();
    audioPlayer = FlutterSoundPlayer();

    await audioPlayer.openPlayer();
    await audioRecorder.openRecorder();
  }

  void setData({
    String fileName = 'audio.mp4',
    Codec codec = Codec.aacMP4,
    int sampleRate = 16000,
  }) {
    this.fileName = fileName;
    this.codec = codec;
  }

  Future<void> record() async {
    final PermissionStatus permissionStatus = await Permission.microphone.request();

    if (permissionStatus.isGranted) {
      await audioRecorder.startRecorder(
        toFile: fileName,
        codec: codec,
        audioSource: AudioSource.microphone,
      );
    } else {
      throw Exception("Permission Denied");
    }
  }

  Future<void> stopRecorder() async {
    await audioRecorder.stopRecorder();
  }

  Future<void> play() async {
    await audioPlayer.startPlayer(
      fromURI: fileName,
      whenFinished: () {},
    );
  }

  Future<void> stopPlayer() async {
    await audioPlayer.stopPlayer();
  }

  Future<void> dispose() async {
    await audioPlayer.closePlayer();
    await audioRecorder.closeRecorder();
  }
}
