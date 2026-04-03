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
      title: 'go_router Demo 02',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// Basic Router Configuration + Path & Query Parameters (Task 2)
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    // NEW: Path + Query Parameters route
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'unknown';
        final name = state.uri.queryParameters['name'];   // ← Correct way in go_router 17.2.0
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
      appBar: AppBar(title: const Text('Home Screen - Demo 02')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Home!\n(Path & Query Parameters)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),

            // Old button from demo01
            ElevatedButton(
              onPressed: () => context.go('/about'),
              child: const Text('Go to About Screen'),
            ),

            const SizedBox(height: 20),

            // NEW buttons as shown in lab slides
            ElevatedButton(
              onPressed: () => context.go('/product/42?name=Smartphone'),
              child: const Text('View Product (ID=42, Name=Smartphone)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/product/101?name=Laptop'),
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

// NEW Screen for Task 2
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