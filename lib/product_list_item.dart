class ProductListItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  ProductListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductListItem.fromJson(Map<String, dynamic> json) {
    return ProductListItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}
