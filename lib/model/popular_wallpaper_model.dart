class PopularWallpaper {
  String? id;
  String? postImage;

  PopularWallpaper({this.id, this.postImage});

  PopularWallpaper.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    postImage = json["post_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["post_image"] = postImage;
    return data;
  }

  static List<PopularWallpaper> getPopularWallpaper(List<dynamic> data) {
    return data.map((e) => PopularWallpaper.fromJson(e)).toList();
  }
}
