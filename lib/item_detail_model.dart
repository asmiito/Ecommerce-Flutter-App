class ItemDetailModel {
  late String id, title, img ;
  late int sellingPrice, totalPrice;

  ItemDetailModel(
      {
      required this.id,
      required this.img,
      required this.sellingPrice,
      required this.title,
      required this.totalPrice,
     });

  ItemDetailModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    img = map['img'];
    sellingPrice = map['sell_price'];
    totalPrice = map['total_price'];
  }
}
