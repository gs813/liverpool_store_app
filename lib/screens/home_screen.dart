import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);

    int total = productProvider.products.length;

    int available = productProvider.products
        .where((p) => p.status == "Available")
        .length;

    int outOfStock = productProvider.products
        .where((p) => p.status == "Out of Stock")
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liverpool Store Dashboard"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Card(
              child: ListTile(
                title: const Text("สินค้าทั้งหมด"),
                trailing: Text(
                  total.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("สินค้าพร้อมขาย"),
                trailing: Text(
                  available.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("สินค้าหมด"),
                trailing: Text(
                  outOfStock.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("ดูรายการสินค้า"),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListScreen(),
                  ),
                );

              },
            )

          ],
        ),
      ),
    );
  }
}