import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/consts/colors.dart';
import 'package:music/consts/textstyle.dart';
import 'package:music/controllers/player_controllers.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  Player({super.key, required this.data});
  var controller = Get.find<PLayercontroller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
            Expanded(
              child: Obx(
                () => Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(
                        Icons.music_note_rounded,
                        size: 40,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        "${data[controller.playIndex.value].displayNameWOExt}",
                        overflow: TextOverflow.ellipsis,
                        style: oruStayle(color: bgDarkColor, size: 23),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "${data[controller.playIndex.value].artist.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: oruStayle(
                            color: bgDarkColor,
                            size: 16,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              controller.position.value,
                              style: oruStayle(color: bgColor),
                            ),
                            Expanded(
                                child: Slider(
                                    thumbColor: sliderColor,
                                    inactiveColor: bgColor,
                                    activeColor: sliderColor,
                                    min: Duration(seconds: 0)
                                        .inSeconds
                                        .toDouble(),
                                    max: controller.max.value,
                                    value: controller.value.value,
                                    onChanged: (newValue) {
                                      controller.changeDurationToSeconds(
                                          newValue.toInt());
                                    })),
                            Text(
                              controller.duration.value,
                              style: oruStayle(color: bgColor),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.playSong(
                                  data[controller.playIndex.value - 1].uri,
                                  controller.playIndex.value - 1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_outlined,
                              size: 30,
                              color: bgDarkColor,
                            ),
                          ),
                          Obx(
                            () => CircleAvatar(
                              radius: 25,
                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              child: Transform.scale(
                                  scale: 2,
                                  child: IconButton(
                                      onPressed: () {
                                        if (controller.isPlaying.value) {
                                          controller.audioplayer.pause();
                                          controller.isPlaying(false);
                                        } else {
                                          controller.audioplayer.play();
                                          controller.isPlaying(true);
                                        }
                                      },
                                      icon: controller.isPlaying.value
                                          ? Icon(
                                              Icons.pause,
                                              color: Color.fromARGB(
                                                  255, 0, 149, 255),
                                            )
                                          : Icon(
                                              Icons.play_arrow,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ))),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.playSong(
                                    data[controller.playIndex.value + 1].uri,
                                    controller.playIndex.value + 1);
                              },
                              icon: const Icon(
                                Icons.skip_next_outlined,
                                size: 30,
                                color: bgDarkColor,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
