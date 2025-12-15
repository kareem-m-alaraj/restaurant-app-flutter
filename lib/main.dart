import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16.0),
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Implement profile functionality here
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PromotionsBanner(),
            const SectionTitle(title: 'Popular Items'),
            PopularItems(),
            const SectionTitle(title: 'Menu Categories'),
            MenuCategories(),
            const QuickAccessButtons(),
            const SectionTitle(title: 'Current Offers'),
            const OffersSection(),
            const SectionTitle(title: 'Customer Reviews'),
            const ReviewsSection(),
            const ContactSection(),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Order History'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class PromotionsBanner extends StatelessWidget {
  const PromotionsBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: PageView(
        children: [
          Image.asset('images/promotion3.jpg', fit: BoxFit.cover),
          Image.asset('images/promotion2.jpg', fit: BoxFit.cover),
          Image.asset('images/promotion1.jpg', fit: BoxFit.cover),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class PopularItems extends StatelessWidget {
  PopularItems({Key? key}) : super(key: key);

  final List<String> items = [
    'images/item1.jpg',
    'images/item2.jpeg',
    'images/item3.jpeg',
    'images/item4.jpeg',
    'images/item5.jpeg',
    'images/item6.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150.0,
            margin: const EdgeInsets.all(8.0),
            child: Image.asset(items[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}

class MenuCategories extends StatelessWidget {
  MenuCategories({Key? key}) : super(key: key);

  final List<String> categories = ['Starters', 'Main Course', 'Desserts', 'Beverages'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: categories.map((category) {
          return Chip(
            label: Text(category),
            backgroundColor: Colors.grey[300],
          );
        }).toList(),
      ),
    );
  }
}

class QuickAccessButtons extends StatelessWidget {
  const QuickAccessButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Implement order functionality here
            },
            child: const Text('Order Now'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement reservation functionality here
            },
            child: const Text('Reservations'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement loyalty functionality here
            },
            child: const Text('Loyalty/Rewards'),
          ),
        ],
      ),
    );
  }
}

class OffersSection extends StatelessWidget {
  const OffersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.grey[300],
      margin: const EdgeInsets.all(8.0),
      child: const Center(
        child: Text('Special Offers'),
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      color: Colors.grey[300],
      margin: const EdgeInsets.all(8.0),
      child: const Center(
        child: Text('Reviews Carousel'),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Our Location', style: Theme.of(context).textTheme.titleLarge),
          Container(
            height: 150.0,
            color: Colors.grey[300],
            margin: const EdgeInsets.all(8.0),
            child: const Center(
              child: Text('Map Here'),
            ),
          ),
          Text('Contact Us', style: Theme.of(context).textTheme.titleLarge),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Phone: 123-456-7890\nAddress: 123 Main Street, City, Country'),
          ),
        ],
      ),
    );
  }
}
