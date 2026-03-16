class Product {

  int? id;
  String name;
  double price;
  int stock;
  String category;
  String status;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'category': category,
      'status': status,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      stock: map['stock'],
      category: map['category'],
      status: map['status'],
    );
  }
}