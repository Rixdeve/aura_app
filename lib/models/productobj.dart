class Product {
  final String id;
  final String productName;
  final String imageUrl;
  final String description;
  final double price;
  final double? discountedPrice;
  final String types;
  final String availability;
  final int qty;
  final String brand;
  final String? watchColor;
  final String category;

  Product({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.discountedPrice,
    required this.types,
    required this.availability,
    required this.qty,
    required this.brand,
    this.watchColor,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      productName: json['product_name'],
      imageUrl: json['img_url'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      discountedPrice: json['discounted_price'] != null
          ? double.tryParse(json['discounted_price'].toString())
          : null,
      types: json['types'],
      availability: json['availability'],
      qty: int.tryParse(json['qty'].toString()) ?? 0,
      brand: json['brand'],
      watchColor: json['watch_color'],
      category: json['category'],
    );
  }
}
