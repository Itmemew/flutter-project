class ModelBank {
  int id;
  String nameEn;
  String nameTh;
  String color;
  String img;
  bool select;

  ModelBank({
    required this.id,
    required this.nameEn,
    required this.nameTh,
    required this.color,
    required this.img,
    required this.select,
  });

  factory ModelBank.fromJson(Map<String, dynamic> json) => ModelBank(
    id: json["id"],
    nameEn: json["name_en"],
    nameTh: json["name_th"],
    color: json["color"],
    img: json["img"],
    select: json["select"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_en": nameEn,
    "name_th": nameTh,
    "color": color,
    "img": img,
    "select": select,
  };
}

