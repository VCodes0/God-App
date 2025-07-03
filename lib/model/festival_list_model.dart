// ignore_for_file: no_leading_underscores_for_local_identifiers

class FestivalList {
  List<Data>? data;
  String? lastUpdate;

  FestivalList({this.data, this.lastUpdate});

  FestivalList.fromJson(Map<String, dynamic> json) {
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
}

class Data {
  String? id;
  String? name;
  String? catImage;

  Data({this.id, this.name, this.catImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    catImage = json["cat_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["cat_image"] = catImage;
    return _data;
  }
}
