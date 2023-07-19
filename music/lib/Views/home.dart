import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/Views/player.dart';
import 'package:music/consts/colors.dart';
import 'package:music/consts/textStyle.dart';
import 'package:music/controllers/player_controllers.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PLayercontroller());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
          leading: const Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text('Music Player', style: oruStayle(size: 18)),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQurey.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "song not founded",
                  style: TextStyle(color: Colors.white),
                ));
              } else {
                print(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext contect, int index) {
                      return Container(
                        margin: EdgeInsets.all(4),
                        child: Obx(
                          () => ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: bgColor,
                            title: Text(
                                "${snapshot.data![index].displayNameWOExt}",
                                overflow: TextOverflow.ellipsis,
                                style: oruStayle(color: whiteColor, size: 15)),
                            subtitle: Text(
                              "${snapshot.data![index].artist}",
                              style: oruStayle(color: whiteColor, size: 12),
                            ),
                            leading: QueryArtworkWidget(
                              id: snapshot.data![index].id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const Icon(
                                Icons.music_note,
                                color: Colors.lightBlue,
                              ),
                            ),
                            trailing: controller.playIndex.value == index &&
                                    controller.isPlaying.value
                                ? const Icon(
                                    Icons.pause_circle,
                                    color: Colors.blue,
                                    size: 26,
                                  )
                                : const Icon(
                                    Icons.play_circle_filled_rounded,
                                    color: whiteColor,
                                    size: 26,
                                  ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Player(
                                          data: snapshot.data!,
                                        )),
                              );
                              controller.playSong(
                                  snapshot.data![index].uri, index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }));
  }
}
