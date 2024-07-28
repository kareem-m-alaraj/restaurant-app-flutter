import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16.0),
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Name'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Implement profile functionality here
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PromotionsBanner(),
            SectionTitle(title: 'Popular Items'),
            PopularItems(),
            SectionTitle(title: 'Menu Categories'),
            MenuCategories(),
            QuickAccessButtons(),
            SectionTitle(title: 'Current Offers'),
            OffersSection(),
            SectionTitle(title: 'Customer Reviews'),
            ReviewsSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Order History'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class PromotionsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }
}

class PopularItems extends StatelessWidget {
  final List<String> items = ['images/item1.jpg',
    'images/item2.jpeg',
    'images/item3.jpeg',
    'images/item4.jpeg',
    'images/item5.jpeg',
    'images/item6.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150.0,
            margin: EdgeInsets.all(8.0),
            child: Image.asset(items[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}

class MenuCategories extends StatelessWidget {
  final List<String> categories = ['Starters', 'Main Course', 'Desserts', 'Beverages'];

  @override
  Widget build(BuildContext context) {
    return Wrap(

      spacing: 8.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        return Chip(
          label: Text(category),
          backgroundColor: Colors.grey[300],
        );
      }).toList(),
    );
  }
}

class QuickAccessButtons extends StatelessWidget {
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
            child: Text('Order Now'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement reservation functionality here
            },
            child: Text('Reservations'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement loyalty functionality here
            },
            child: Text('Loyalty/Rewards'),
          ),
        ],
      ),
    );
  }
}

class OffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.grey[300],
      margin: EdgeInsets.all(8.0),
      child: Center(
        child: Text('Special Offers'),
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      color: Colors.grey[300],
      margin: EdgeInsets.all(8.0),
      child: Center(
        child: Text('Reviews Carousel'),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Our Location', style: Theme.of(context).textTheme.headline6),
          Container(
            height: 150.0,
            color: Colors.grey[300],
            margin: EdgeInsets.all(8.0),
            child: Center(
              child: Text('Map Here'),
            ),
          ),
          Text('Contact Us', style: Theme.of(context).textTheme.headline6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Phone: 123-456-7890\nAddress: 123 Main Street, City, Country'),
          ),
        ],
      ),
    );
  }
}
