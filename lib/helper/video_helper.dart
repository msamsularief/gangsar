import 'package:youtube_player_iframe/youtube_player_iframe.dart';

///Digunakan untuk melihat video thumbnail dari video yang ada di YouTube.
class VideoHelper {
  static String getVideoId(String videoUrl) {
    String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
      if (!url.contains("http") && (url.length == 11)) return url;
      if (trimWhitespaces) url = url.trim();

      for (var exp in [
        RegExp(
            r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
        RegExp(
            r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
        RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
      ]) {
        Match? match = exp.firstMatch(url);
        if (match != null && match.groupCount >= 1) return match.group(1);
      }

      return null;
    }

    String? videoId = convertUrlToId(videoUrl);
    // print(videoId);

    return "$videoId";
  }

  static String getVideoThumbnail(String videoUrl) {
    String getThumbnail({
      required String videoId,
      String quality = ThumbnailQuality.standard,
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
}
