class ServiceItemModel {
  final String title;
  final dynamic price;
  final String image;

  ServiceItemModel(
      {required this.title, required this.price, required this.image});

  factory ServiceItemModel.fromJson(json) {
    return ServiceItemModel(
      title: json['title'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'image': image,
    };
  }
}
