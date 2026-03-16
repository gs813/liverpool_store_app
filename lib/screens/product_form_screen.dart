import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  String selectedCategory = "Jersey";

  @override
  void initState() {
    super.initState();

    // ถ้ามี product = โหมดแก้ไข
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      priceController.text = widget.product!.price.toString();
      selectedCategory = widget.product!.category;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void saveProduct() {

    final provider = Provider.of<ProductProvider>(context, listen: false);

    if (nameController.text.isEmpty || priceController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("กรุณากรอกข้อมูลให้ครบ"),
        ),
      );

      return;
    }

    final product = Product(
      id: widget.product?.id,
      name: nameController.text,
      price: double.tryParse(priceController.text) ?? 0,
      stock: 10,
      category: selectedCategory,
      status: "Available",
    );

    if (widget.product == null) {
      provider.addProduct(product);
    } else {
      provider.updateProduct(product);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null ? "เพิ่มสินค้า" : "แก้ไขสินค้า",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "ชื่อสินค้า",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ราคา",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: "หมวดหมู่สินค้า",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Jersey",
                  child: Text("Jersey"),
                ),
                DropdownMenuItem(
                  value: "Shoes",
                  child: Text("Shoes"),
                ),
                DropdownMenuItem(
                  value: "Scarf",
                  child: Text("Scarf"),
                ),
                DropdownMenuItem(
                  value: "Accessories",
                  child: Text("Accessories"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveProduct,
                child: Text(
                  widget.product == null ? "เพิ่มสินค้า" : "บันทึกการแก้ไข",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}