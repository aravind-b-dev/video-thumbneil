import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:  MyHomePage(),
    );
  }
}


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

   // String url = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4";
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
        title: const Text("Video Compress"),
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
              // height: MediaQuery.of(context).size.height *.3,
              // width: MediaQuery.of(context).size.width,
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


class GenThumbnailImage extends StatefulWidget {
  final ThumbnailRequest thumbnailRequest;

  const GenThumbnailImage({required this.thumbnailRequest});

  @override
  _GenThumbnailImageState createState() => _GenThumbnailImageState();
}

class _GenThumbnailImageState extends State<GenThumbnailImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThumbnailResult>(
      future: genThumbnail(widget.thumbnailRequest),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final _image = snapshot.data.image;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _image,
            ],
          );
        } else if (snapshot.hasError) {
          return Container(
            height: 90,
            width: 95,
            child: Center(
              child: Lottie.network(
                'https://assets2.lottiefiles.com/private_files/lf30_uDAsLk.json',
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
          );
        } else {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 90,
                  width: 95,
                  child: Center(
                    child: Lottie.network(
                      'https://assets9.lottiefiles.com/packages/lf20_rsgxuwx0.json',
                      repeat: true,
                      reverse: true,
                      animate: true,
                    ),
                  ),
                )
              ]);
        }
      },
    );
  }
}

class ThumbnailRequest {
  final String video;
  final String thumbnailPath;
  final ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;

  const ThumbnailRequest(
      {required this.video,
        required this.thumbnailPath,
        required this.imageFormat,
        required this.maxHeight,
        required this.maxWidth,
        required this.timeMs,
        required this.quality});
}

class ThumbnailResult {
  final Image image;
  final int dataSize;
  final int height;
  final int width;
  const ThumbnailResult({required this.image, required this.dataSize, required this.height, required this.width});
}

Future<ThumbnailResult> genThumbnail(ThumbnailRequest r) async {
  //WidgetsFlutterBinding.ensureInitialized();
  Uint8List bytes;
  final Completer<ThumbnailResult> completer = Completer();
  if (r.thumbnailPath != null) {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: r.video,
        thumbnailPath: r.thumbnailPath,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality);

    print("thumbnail file is located: $thumbnailPath");

    final file = File(thumbnailPath!);
    bytes = file.readAsBytesSync();
  } else {
    bytes = (await VideoThumbnail.thumbnailData(
        video: r.video,
        imageFormat: r.imageFormat,
        maxHeight: r.maxHeight,
        maxWidth: r.maxWidth,
        timeMs: r.timeMs,
        quality: r.quality))!;
  }

  int _imageDataSize = bytes.length;
  print("image size: $_imageDataSize");

  final _image = Image.memory(bytes);
  _image.image
      .resolve(ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(ThumbnailResult(
      image: _image,
      dataSize: _imageDataSize,
      height: 80,
      width: 80,
    ));
  }));
  return completer.future;
}