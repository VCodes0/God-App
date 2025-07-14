class Data {
  String? id;
  String? name;
  String? catImage;

  Data({this.id, this.name, this.catImage});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      name: json["name"],
      catImage: json["cat_image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "cat_image": catImage};
  }

  static List<Data> getData(List<dynamic> data) {
    return data.map((item) => Data.fromJson(item)).toList();
  }
}
