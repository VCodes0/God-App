class GodCategory {
  List<Data>? data;
  String? lastUpdate;

  GodCategory({this.data, this.lastUpdate});

  GodCategory.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    lastUpdate = json["last_update"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["last_update"] = lastUpdate;
    return _data;
  }

  static List<GodCategory> getRecentPlayed(List<dynamic> data) {
    return data.map((e) => GodCategory.fromJson(e)).toList();
  }
}

class Data {
  String? id;
  String? catName;
  String? catImage;

  Data({this.id, this.catName, this.catImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    catName = json["cat_name"];
    catImage = json["cat_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["cat_name"] = catName;
    data["cat_image"] = catImage;
    return data;
  }

  static List<Data> getData(List<dynamic> data) {
    return data.map((e) => Data.fromJson(e)).toList();
  }
}
