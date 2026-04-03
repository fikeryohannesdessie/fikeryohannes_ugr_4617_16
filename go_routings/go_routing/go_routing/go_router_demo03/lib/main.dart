import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'go_router Demo 03',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// Named Routes + Navigation Methods (Task 3)
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    // Named route for Home
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    // Named route for About
    GoRoute(
      name: 'about',
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    // Named route for Product (with path & query parameters)
    GoRoute(
      name: 'product',
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'unknown';
        final name = state.uri.queryParameters['name'];
        return ProductDetailScreen(id: id, name: name);
      },
    ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen - Named Routes')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Home!\n(Named Routes + Navigation Methods)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 40),

            // Named navigation (as shown in lab slides)
            ElevatedButton(
              onPressed: () => context.goNamed('about'),
              child: const Text('Go to About Screen'),
            ),

            const SizedBox(height: 20),

            // Named navigation with path + query parameters
            ElevatedButton(
              onPressed: () => context.goNamed(
                'product',
                pathParameters: {'id': '42'},
                queryParameters: {'name': 'Smartphone'},
              ),
              child: const Text('View Product (ID=42, Name=Smartphone)'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => context.goNamed(
                'product',
                pathParameters: {'id': '101'},
                queryParameters: {'name': 'Laptop'},
              ),
              child: const Text('View Product (ID=101, Name=Laptop)'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Screen')),
      body: const Center(
        child: Text('This is the About Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String id;
  final String? name;

  const ProductDetailScreen({
    super.key,
    required this.id,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Product ID: $id',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (name != null)
              Text(
                'Product Name: $name',
                style: const TextStyle(fontSize: 22),
              )
            else
              const Text(
                'No name provided',
                style: TextStyle(fontSize: 22, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}