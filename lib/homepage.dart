import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:video_thumbneil/thumbnail.dart';


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;
  String url = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4";

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
    const BetterPlayerConfiguration(
        aspectRatio: 16/9,
        fit: BoxFit.contain,
        autoPlay: true,
        controlsConfiguration :BetterPlayerControlsConfiguration(
          showControls: true,
          enableSkips: false,
          enableFullscreen: true,
          // enableMute : false,
          // enableProgressText: false,
          // enableProgressBar :false,
          enablePip:false,
          enablePlayPause:false,
          enableOverflowMenu: false,
        )
    );

    _betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        url
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade400,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withAlpha(20),
        title: const Text("Video Thumbnail"),
        centerTitle: true,
        actions: [
          Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_rsgxuwx0.json',
              repeat: true,
              reverse: true,
              animate: true,
              width: 50
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 2),
                        blurRadius: 12,
                        spreadRadius: 1)
                  ],
                  color: Color(0xff5cafaf)),
              margin:  const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),

              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10),
                child: BetterPlayerMultipleGestureDetector(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BetterPlayer(
                      controller: _betterPlayerController,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25,),

            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 2),
                        blurRadius: 12,
                        spreadRadius: 1)
                  ],
                  color: Color(0xff5cafaf)),
              margin:  const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              // height: MediaQuery.of(context).size.height *.3,
              // width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10),
                child: Container(
                  child:  GenThumbnailImage(
                      thumbnailRequest: ThumbnailRequest(
                          video: url,
                          thumbnailPath: "/storage/emulated/0/Download",  //you can change the path
                          imageFormat: ImageFormat.PNG,
                          maxHeight: 200,
                          maxWidth: 200,
                          timeMs: 0,
                          quality: 100)),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
