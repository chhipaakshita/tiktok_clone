

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:video_compress/video_compress.dart';

class UploadController extends GetxController{
  compressFileVideo (String videoFilePath) async{
     final compressVideoFile =  await VideoCompress.compressVideo(videoFilePath,quality: VideoQuality.LowQuality);

     return compressVideoFile!.file;
  }
  uploadCompressVideoFileToStorage(String videoId, String videoFilePath) async{
      UploadTask videoUploadTask = FirebaseStorage.instance.ref()
                                    .child("all videos")
                                    .child(videoId)
                                    .putFile(await compressFileVideo(videoFilePath));

      TaskSnapshot taskSnapshot = await videoUploadTask;

     String downloadUrlOfUploadVideo =  await taskSnapshot.ref.getDownloadURL();
     return downloadUrlOfUploadVideo;
  }
  getThumbnailImage(String videoFilePath) async{
   final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);

   return thumbnailImage;
  }
  uploadThumbnailImageToFirebaseStorage(String videoId, String videoFilePath) async{
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
        .child("all thumbnails")
        .child(videoId)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot taskSnapshot = await thumbnailUploadTask;

    String downloadUrlOfUploadThumbnail =  await taskSnapshot.ref.getDownloadURL();
    return downloadUrlOfUploadThumbnail;
  }

  saveVideoInfoToFirebaseStorage(String artistSongName,String descpTag,String videoFilePath,BuildContext context) async{
      try{
        String videoId = DateTime.now().millisecond.toString();
        //upload video to sorage
        String downloadVideoUrl = await uploadCompressVideoFileToStorage(videoId, videoFilePath);
        //upload thumbnail to storage
       String downloadThumbnailUrl =  await uploadThumbnailImageToFirebaseStorage(videoId, videoFilePath);
      }catch(errorMsg){
          Get.snackbar("Video upload failed","Error occurr");
      }
  }
}