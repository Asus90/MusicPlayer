import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PLayercontroller extends GetxController {
  final audioQurey = OnAudioQuery();
  final audioplayer = AudioPlayer();

  var isPlaying = false.obs;
  var playIndex = 0.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    checkpermission();
  }

  updateDuration() {
    audioplayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioplayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioplayer.seek(duration);
  }

  playSong(String? uri, int index) {
    playIndex.value = index;
    try {
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioplayer.play();
      isPlaying(true);
      updateDuration();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkpermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkpermission();
    }
  }
}
