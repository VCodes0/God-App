class RecentlyPlayed {
  String? id;
  String? title;
  String? withoutBgImage;
  String? bgImage;
  String? audio;
  String? mainImage;

  RecentlyPlayed({
    this.id,
    this.title,
    this.withoutBgImage,
    this.bgImage,
    this.audio,
    this.mainImage,
  });

  factory RecentlyPlayed.fromJson(Map<String, dynamic> json) {
    return RecentlyPlayed(
      id: json["id"]?.toString(),
      title: json["title"],
      withoutBgImage: json["without_bg_image"],
      bgImage: json["bg_image"],
      audio: json["audio"],
      mainImage: json["main_image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "without_bg_image": withoutBgImage,
      "bg_image": bgImage,
      "audio": audio,
      "main_image": mainImage,
    };
  }

  static List<RecentlyPlayed> getRecentPlayed(List<dynamic> data) {
    return data.map((e) => RecentlyPlayed.fromJson(e)).toList();
  }
}
