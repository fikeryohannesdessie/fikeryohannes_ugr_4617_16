import 'package:flutter/material.dart';

void main() {
  runApp(CatalogApp());
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

class CatalogApp extends StatelessWidget {
  final List<Product> products = List.generate(
    10,
    (index) => Product("Product $index", (index + 1) * 10.0),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CatalogScreen(products),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CatalogScreen extends StatelessWidget {
  final List<Product> products;

  CatalogScreen(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Catalog")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(products[index].name),
                  Text("\$${products[index].price}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
