import 'dart:convert';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:http/http.dart' as http;

///Digunakan untuk melihat video thumbnail dari video yang ada di YouTube.
class VideoHelper {
  static String getVideoId(String videoUrl) {
    String? id = YoutubePlayer.convertUrlToId(videoUrl);

    String? videoId = id;

    return "$videoId";
  }

  static String getVideoThumbnail(String videoUrl) {
    String getThumbnail({
      required String videoId,
      String quality = ThumbnailQuality.medium,
      bool webp = true,
    }) =>
        webp
            ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
            : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';

    String? videoId = getVideoId(videoUrl);
    String thumbnailUrl = getThumbnail(videoId: videoId, webp: false);
    print("THUMBNAIL : $thumbnailUrl");

    return thumbnailUrl;
  }

  static getVideoDetail(String videoUrl) async {
    Future<dynamic> getDetail(String videoUrl) async {
      String embedUrl =
          "https://www.youtube.com/oembed?url=$videoUrl&format=json";

      //store http request response to res variable
      var res = await http.get(Uri.parse(embedUrl));
      print("get youtube detail status code: ${res.statusCode.toString()}\n");

      try {
        if (res.statusCode == 200) {
          //return the json from the response
          return json.decode(res.body);
        } else {
          //return null if status code other than 200
          return null;
        }
      } on FormatException catch (e) {
        print('invalid JSON' + e.toString());
        //return null if error
        return null;
      }
    }

    var jsonData = await getDetail(videoUrl);

    return jsonData;
  }
}
