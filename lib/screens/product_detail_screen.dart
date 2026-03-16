import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {

  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  // ฟังก์ชันเลือกรูปตามหมวดหมู่
  String getProductImage(String category) {
    switch (category) {
      case "Jersey":
        return "assets/images/jersey.webp";
      case "Shoes":
        return "assets/images/shoes.webp";
      case "Scarf":
        return "assets/images/scarf.webp";
      default:
        return "assets/images/bag.webp";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("รายละเอียดสินค้า"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // รูปสินค้า
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    getProductImage(product.category),
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "ราคา : ${product.price} บาท",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "จำนวนสินค้า : ${product.stock}",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 10),

              Text(
                "หมวดหมู่ : ${product.category}",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 10),

              Text(
                "สถานะ : ${product.status}",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              // ปุ่มแก้ไขสินค้า
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("แก้ไขสินค้า"),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductFormScreen(product: product),
                      ),
                    );

                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}