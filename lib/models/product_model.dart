class ProductModel {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final int? oldPrice;
  final int? discount;
  final String? image;
  bool? isFavorite;
  final bool? inCart;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.isFavorite,
    this.inCart,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'].toInt(),
        oldPrice = json['old_price'].toInt(),
        discount = json['discount'].toInt(),
        image = json['image'],
        isFavorite = json['in_favorites'],
        inCart = json['in_cart'];


  ProductModel copyWith({
    String? name,
    String? description,
    int? price,
    int? oldPrice,
    int? discount,
    String? image,
    bool? isFavorite,
    bool? inCart,
  }) {
    return ProductModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
      inCart: inCart ?? this.inCart,
    );
  }
}