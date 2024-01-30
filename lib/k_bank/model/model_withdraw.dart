class ModelWithdraw {
  int id;
  int amount;
  bool selectWithdraw;

  ModelWithdraw({
    required this.id,
    required this.amount,
    required this.selectWithdraw,
  });

  factory ModelWithdraw.fromJson(Map<String, dynamic> json) => ModelWithdraw(
      id: json["id"],
      amount: json["amount"],
      selectWithdraw: json["selectWithdraw"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "selectWithdraw": selectWithdraw,
      };
}
