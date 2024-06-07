import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone/authentication/global.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/input_text_widget.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({Key? key, required this.videoFile, required this.videoPath,}) : super(key: key);
  final File videoFile;
  final String videoPath;

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  VideoPlayerController?  playerController;
  TextEditingController artistSongTextEditingController = TextEditingController();
  TextEditingController descriptionTagTextEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.3,
              child: VideoPlayer(playerController!),
            ),
            SizedBox(height: 30,),
            //upload now =>if user click =>  circular progeess bar display
            //input field
            showProgressBar == true
                ? Container(
                   child: SimpleCircularProgressBar(
                      progressColors: [
                        Colors.green,
                        Colors.blueAccent,
                        Colors.red,
                        Colors.amber,
                        Colors.purpleAccent
                      ],
                      animationDuration: 3,
                      backColor: Colors.white38,
                    ),
                )
                :Column(
                    children: [
                      //artist-song
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: InputTextWidget(
                            textEditingController: artistSongTextEditingController,
                            labelString: "Artist song",
                            isObscure: false,
                            iconData: Icons.music_video_sharp
                        ),
                      ),
                      SizedBox(height: 10,),
                      //description-tags
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: InputTextWidget(
                            textEditingController: descriptionTagTextEditingController,
                            labelString: "Description-tags",
                            isObscure: false,
                            iconData: Icons.slideshow_sharp
                        ),
                      ),
                      SizedBox(height: 20,),
                      //upload now buton
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 54,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: InkWell(
                          onTap: (){
                          },
                          child: Center(
                            child: Text("Upload Now",style: TextStyle(
                                fontSize: 20,
                                color: Colors.black ,
                                fontWeight: FontWeight.w700
                            ),),
                          ),
                        ),
                      ),
                    ],
                 ),

          ],
        ),
      ),
    );
  }
}
