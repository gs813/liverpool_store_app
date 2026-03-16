import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'product_form_screen.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  String searchText = "";

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);

    final products = productProvider.products.where((product) {
      return product.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Liverpool Store",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // Search
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "ค้นหาสินค้า...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          Expanded(
            child: products.isEmpty
                ? const Center(child: Text("ไม่พบสินค้า"))
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {

                      final product = products[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },

                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [

                                // รูปสินค้า
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
  product.category == "Jersey"
      ? "assets/images/jersey.webp"
      : product.category == "Shoes"
          ? "assets/images/shoes.webp"
          : product.category == "Scarf"
              ? "assets/images/scarf.webp"
              : "assets/images/bag.webp",
  width: 70,
  height: 70,
  fit: BoxFit.cover,
),
                                ),

                                const SizedBox(width: 12),

                                // ข้อมูลสินค้า
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        "ราคา ${product.price} บาท",
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        "หมวดหมู่ : ${product.category}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ปุ่มลบ
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {

                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("ยืนยันการลบ"),
                                          content: const Text(
                                              "คุณต้องการลบสินค้านี้หรือไม่?"),
                                          actions: [

                                            TextButton(
                                              child: const Text("ยกเลิก"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),

                                            TextButton(
                                              child: const Text(
                                                "ลบ",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {

                                                if (product.id != null) {
                                                  productProvider
                                                      .deleteProduct(product.id!);
                                                }

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductFormScreen(),
            ),
          );

        },
      ),
    );
  }
}