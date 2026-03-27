import 'package:flutter/material.dart';

void main() => runApp(const CatalogApp());

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const HomeScreen(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final Color color;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.color,
  });
}

class Catalog {
  final String name;
  final String currency;
  final List<Product> products;

  const Catalog({
    required this.name,
    required this.currency,
    required this.products,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Catalog> catalogs = [
    Catalog(
      name: 'Electronics',
      currency: '\$',
      products: [
        Product(
          name: 'Wireless Mouse',
          price: 25.99,
          imageUrl: 'https://picsum.photos/id/1/200/200',
          color: Colors.blue,
        ),
        Product(
          name: 'Bluetooth Speaker',
          price: 49.99,
          imageUrl: 'https://picsum.photos/id/2/200/200',
          color: Colors.green,
        ),
        Product(
          name: 'USB Charger',
          price: 15.49,
          imageUrl: 'https://picsum.photos/id/3/200/200',
          color: Colors.red,
        ),
        Product(
          name: 'Gaming Keyboard',
          price: 89.99,
          imageUrl: 'https://picsum.photos/id/4/200/200',
          color: Colors.black,
        ),
        Product(
          name: 'Smartphone Case',
          price: 19.99,
          imageUrl: 'https://picsum.photos/id/5/200/200',
          color: Colors.purple,
        ),
        Product(
          name: 'VR Headset',
          price: 299.99,
          imageUrl: 'https://picsum.photos/id/6/200/200',
          color: Colors.grey,
        ),
      ],
    ),
    Catalog(
      name: 'Books',
      currency: '€',
      products: [
        Product(
          name: 'Flutter Cookbook',
          price: 39.99,
          imageUrl: 'https://picsum.photos/id/7/200/200',
          color: Colors.teal,
        ),
        Product(
          name: 'Dart Programming',
          price: 29.99,
          imageUrl: 'https://picsum.photos/id/8/200/200',
          color: Colors.orange,
        ),
        Product(
          name: 'UI/UX Design Guide',
          price: 24.49,
          imageUrl: 'https://picsum.photos/id/9/200/200',
          color: Colors.pink,
        ),
        Product(
          name: 'Mobile App Development',
          price: 49.99,
          imageUrl: 'https://picsum.photos/id/10/200/200',
          color: Colors.brown,
        ),
        Product(
          name: 'Algorithm Handbook',
          price: 34.99,
          imageUrl: 'https://picsum.photos/id/11/200/200',
          color: Colors.indigo,
        ),
        Product(
          name: 'Web Development Basics',
          price: 19.99,
          imageUrl: 'https://picsum.photos/id/12/200/200',
          color: Colors.cyan,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: catalogs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catalogs'),
          bottom: TabBar(
            tabs: catalogs.map((catalog) => Tab(text: catalog.name)).toList(),
          ),
        ),
        body: TabBarView(
          children: catalogs
              .map((catalog) => CatalogScreen(catalog: catalog))
              .toList(),
        ),
      ),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, required this.catalog});

  final Catalog catalog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: catalog.products.length,
        itemBuilder: (context, index) {
          final product = catalog.products[index];
          return Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(product.imageUrl, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        '${catalog.currency}${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: product.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
