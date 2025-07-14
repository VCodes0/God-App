class AllGodWallpaper {
  String? id;
  String? images;

  AllGodWallpaper({this.id, this.images});

  AllGodWallpaper.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    images = json["images"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["images"] = images;
    return data;
  }

  static List<AllGodWallpaper> getWallpaperData(List<dynamic> data) {
    return data.map((item) => AllGodWallpaper.fromJson(item)).toList();
  }
}
