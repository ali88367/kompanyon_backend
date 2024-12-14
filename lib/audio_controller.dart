import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  RxString playingUrl = ''.obs;

  AudioController() {
    audioPlayer.onPlayerComplete.listen((_) {
      playingUrl.value = '';
    });
  }

  Future<void> playPauseAudio(String url) async {
    try {
      if (playingUrl.value == url) {
        await audioPlayer.pause();
        playingUrl.value = '';
      } else {
        await audioPlayer.stop(); // Stop any currently playing audio
        await audioPlayer.play(UrlSource(url));
        playingUrl.value = url;
      }
    } catch (e) {
      print("An error occurred while playing audio: $e");
    }
  }

  Future<void> stopAudio() async {
    try {
      await audioPlayer.stop();
      playingUrl.value = '';
    } catch (e) {
      print("An error occurred while stopping audio: $e");
    }
  }

  @override
  void onClose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.onClose();
  }
}

