class Product {
  const Product({
    required this.id,
    required this.categoryBelong,
    required this.title,
    required this.imageUrl,
    required this.specification,
    required this.price,
  });

  final String id;
  final String categoryBelong;
  final String title;
  final String imageUrl;
  final String price;
  final String specification;
}
