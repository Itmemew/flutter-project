class ModelMenuTransfer {
  int id;
  String menuEn;
  String menuTh;

  ModelMenuTransfer({
    required this.id,
    required this.menuEn,
    required this.menuTh,
  });

  factory ModelMenuTransfer.fromJson(Map<String, dynamic> json) => ModelMenuTransfer(
    id: json["id"],
    menuEn: json["menu_en"],
    menuTh: json["menu_th"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "menu_en": menuEn,
    "menu_th": menuTh,
  };
}
