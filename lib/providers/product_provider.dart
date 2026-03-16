import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/database_helper.dart';

class ProductProvider extends ChangeNotifier {

  List<Product> _products = [];

  List<Product> get products => _products;

  Future loadProducts() async {
    _products = await DatabaseHelper.instance.getProducts();
    notifyListeners();
  }

  Future addProduct(Product product) async {
    await DatabaseHelper.instance.insertProduct(product);
    await loadProducts();
  }

  Future deleteProduct(int id) async {
    await DatabaseHelper.instance.deleteProduct(id);
    await loadProducts();
  }

  Future updateProduct(Product product) async {

  await DatabaseHelper.instance.updateProduct(product);

  await loadProducts();
}

}