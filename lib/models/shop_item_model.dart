class ShopItemModel {
  final String title;
  final String desc;
  final dynamic price;
  final String image;

  ShopItemModel({
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
  });

  factory ShopItemModel.fromJson(json) {
    return ShopItemModel(
      title: json['title'],
      desc: json['desc'],
      price: json['price'],
      image: json['image'],
    );
  }
}
