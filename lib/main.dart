import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

// ============================================================================
// APP THEME & COLORS
// ============================================================================

class AppColors {
  static const Color primary = Color(0xFFE85D04);
  static const Color primaryDark = Color(0xFFD64800);
  static const Color secondary = Color(0xFF2D3436);
  static const Color accent = Color(0xFFFFC857);
  static const Color background = Color(0xFFFAF9F7);
  static const Color cardBg = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textLight = Color(0xFFB2BEC3);
  static const Color success = Color(0xFF00B894);
  static const Color error = Color(0xFFE17055);
  static const Color starYellow = Color(0xFFFFD700);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savoria Restaurant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const MainPage(),
    );
  }
}

// ============================================================================
// DATA MODELS
// ============================================================================

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final bool isPopular;
  final bool isVegetarian;
  final List<String> tags;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.isPopular = false,
    this.isVegetarian = false,
    this.tags = const [],
  });
}

class CartItem {
  final MenuItem item;
  int quantity;
  String? specialInstructions;

  CartItem({required this.item, this.quantity = 1, this.specialInstructions});

  double get totalPrice => item.price * quantity;
}

class Review {
  final String userName;
  final String avatarUrl;
  final double rating;
  final String comment;

  const Review({
    required this.userName,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
  });
}

// ============================================================================
// SAMPLE DATA
// ============================================================================

class SampleData {
  static const List<MenuItem> menuItems = [
    MenuItem(
      id: '1',
      name: 'Truffle Risotto',
      description: 'Creamy Arborio rice with black truffle and aged Parmesan',
      price: 28.99,
      category: 'Main Course',
      imageUrl:
          'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=400',
      rating: 4.9,
      reviewCount: 128,
      isPopular: true,
      isVegetarian: true,
      tags: ['Chef Special'],
    ),
    MenuItem(
      id: '2',
      name: 'Grilled Salmon',
      description: 'Atlantic salmon with lemon butter sauce and vegetables',
      price: 32.99,
      category: 'Main Course',
      imageUrl:
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400',
      rating: 4.8,
      reviewCount: 95,
      isPopular: true,
      tags: ['Healthy'],
    ),
    MenuItem(
      id: '3',
      name: 'Bruschetta Trio',
      description: 'Classic tomato, mushroom truffle, and roasted pepper',
      price: 14.99,
      category: 'Starters',
      imageUrl:
          'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400',
      rating: 4.7,
      reviewCount: 76,
      isPopular: true,
      isVegetarian: true,
      tags: ['Shareable'],
    ),
    MenuItem(
      id: '4',
      name: 'Tiramisu',
      description: 'Traditional Italian dessert with espresso and mascarpone',
      price: 12.99,
      category: 'Desserts',
      imageUrl:
          'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400',
      rating: 4.9,
      reviewCount: 152,
      isPopular: true,
      isVegetarian: true,
      tags: ['Must Try'],
    ),
    MenuItem(
      id: '5',
      name: 'Craft Cocktail',
      description: 'Signature house blend with premium spirits',
      price: 15.99,
      category: 'Beverages',
      imageUrl:
          'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=400',
      rating: 4.6,
      reviewCount: 64,
      tags: ['21+'],
    ),
    MenuItem(
      id: '6',
      name: 'Wagyu Steak',
      description: 'Premium A5 Japanese Wagyu with truffle butter',
      price: 89.99,
      category: 'Main Course',
      imageUrl:
          'https://images.unsplash.com/photo-1546833998-877b37c2e5c6?w=400',
      rating: 5.0,
      reviewCount: 43,
      isPopular: true,
      tags: ['Premium'],
    ),
    MenuItem(
      id: '7',
      name: 'Caesar Salad',
      description: 'Crisp romaine, house dressing, croutons, Parmesan',
      price: 13.99,
      category: 'Starters',
      imageUrl:
          'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=400',
      rating: 4.5,
      reviewCount: 89,
      isVegetarian: true,
      tags: ['Classic'],
    ),
    MenuItem(
      id: '8',
      name: 'Chocolate Lava Cake',
      description: 'Warm chocolate cake with molten center',
      price: 14.99,
      category: 'Desserts',
      imageUrl:
          'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?w=400',
      rating: 4.8,
      reviewCount: 118,
      isVegetarian: true,
      tags: ['Hot'],
    ),
  ];

  static const List<Review> reviews = [
    Review(
      userName: 'Sarah M.',
      avatarUrl: 'https://i.pravatar.cc/100?img=1',
      rating: 5.0,
      comment: 'Incredible dining experience! The truffle risotto was divine.',
    ),
    Review(
      userName: 'James K.',
      avatarUrl: 'https://i.pravatar.cc/100?img=2',
      rating: 4.5,
      comment: 'Great ambiance and delicious food. The Wagyu was perfect!',
    ),
    Review(
      userName: 'Emily R.',
      avatarUrl: 'https://i.pravatar.cc/100?img=3',
      rating: 5.0,
      comment: 'Perfect anniversary dinner. Staff made us feel special.',
    ),
  ];

  static const List<String> categories = [
    'All',
    'Starters',
    'Main Course',
    'Desserts',
    'Beverages'
  ];

  static const List<Map<String, dynamic>> promotions = [
    {
      'title': 'Weekend Brunch Special',
      'subtitle': '20% off all brunch items',
      'gradient': [Color(0xFFE85D04), Color(0xFFFFC857)],
      'icon': Icons.brunch_dining,
    },
    {
      'title': 'Happy Hour',
      'subtitle': 'Half-price cocktails 4-7 PM',
      'gradient': [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
      'icon': Icons.local_bar,
    },
    {
      'title': 'Family Sunday',
      'subtitle': 'Kids eat free with adult entrée',
      'gradient': [Color(0xFF00B894), Color(0xFF55EFC4)],
      'icon': Icons.family_restroom,
    },
  ];
}

// ============================================================================
// CART MANAGER
// ============================================================================

class CartManager extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.08;
  double get total => subtotal + tax;

  void addItem(MenuItem menuItem, {int quantity = 1, String? instructions}) {
    final existingIndex =
        _items.indexWhere((item) => item.item.id == menuItem.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(
          item: menuItem,
          quantity: quantity,
          specialInstructions: instructions));
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final index = _items.indexWhere((item) => item.item.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// ============================================================================
// LOYALTY MANAGER
// ============================================================================

class LoyaltyManager extends ChangeNotifier {
  int _points = 1250;
  final String _tier = 'Gold';

  int get points => _points;
  String get tier => _tier;

  void addPoints(int amount) {
    _points += amount;
    notifyListeners();
  }

  bool redeemReward(int cost) {
    if (_points >= cost) {
      _points -= cost;
      notifyListeners();
      return true;
    }
    return false;
  }
}

// ============================================================================
// MAIN PAGE
// ============================================================================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final CartManager _cartManager = CartManager();
  final LoyaltyManager _loyaltyManager = LoyaltyManager();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _cartManager.addListener(_onCartChanged);
  }

  void _onCartChanged() {
    if (_cartManager.itemCount > 0) {
      _fabController.forward();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _fabController.dispose();
    _cartManager.removeListener(_onCartChanged);
    super.dispose();
  }

  void _showSearch() {
    showSearch(
      context: context,
      delegate: MenuSearchDelegate(
        menuItems: SampleData.menuItems,
        onItemSelected: (item) => _showItemDetail(item),
      ),
    );
  }

  void _showProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfilePage(loyaltyManager: _loyaltyManager)),
    );
  }

  void _showItemDetail(MenuItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ItemDetailSheet(
        item: item,
        onAddToCart: (qty, instructions) {
          _cartManager.addItem(item, quantity: qty, instructions: instructions);
          Navigator.pop(context);
          _showAddedSnackbar(item);
        },
      ),
    );
  }

  void _showAddedSnackbar(MenuItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('${item.name} added to cart')),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
            label: 'View Cart', textColor: Colors.white, onPressed: _showCart),
      ),
    );
  }

  void _showCart() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CartPage(cartManager: _cartManager)));
  }

  void _showReservations() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ReservationPage()));
  }

  void _showLoyalty() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoyaltyPage(loyaltyManager: _loyaltyManager)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(
        onNavigate: (route) {
          Navigator.pop(context);
          switch (route) {
            case 'cart':
              _showCart();
              break;
            case 'reservations':
              _showReservations();
              break;
            case 'loyalty':
              _showLoyalty();
              break;
            case 'profile':
              _showProfile();
              break;
          }
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            title: const Text(
              'Savoria',
              style: TextStyle(
                  fontFamily: 'Georgia',
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary),
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: _showSearch),
              IconButton(
                  icon: const Icon(Icons.person_outline_rounded),
                  onPressed: _showProfile),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const PromotionsBanner(),
                const SizedBox(height: 24),
                _buildQuickActions(),
                const SizedBox(height: 24),
                _buildSectionHeader('Popular Dishes'),
                PopularItemsSection(
                  items:
                      SampleData.menuItems.where((i) => i.isPopular).toList(),
                  onItemTap: _showItemDetail,
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Browse Menu'),
                MenuCategoriesSection(onItemTap: _showItemDetail),
                const SizedBox(height: 24),
                _buildSectionHeader('Current Offers'),
                const OffersSection(),
                const SizedBox(height: 24),
                _buildSectionHeader('What People Say'),
                const ReviewsSection(),
                const SizedBox(height: 24),
                const ContactSection(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _cartManager.itemCount > 0
          ? ScaleTransition(
              scale: CurvedAnimation(
                  parent: _fabController, curve: Curves.easeOutBack),
              child: FloatingActionButton.extended(
                onPressed: _showCart,
                backgroundColor: AppColors.primary,
                icon: Badge(
                    label: Text('${_cartManager.itemCount}'),
                    child: const Icon(Icons.shopping_bag_outlined)),
                label: Text('\$${_cartManager.total.toStringAsFixed(2)}'),
              ),
            )
          : null,
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: _QuickActionButton(
                  icon: Icons.restaurant_menu,
                  label: 'Order Now',
                  color: AppColors.primary,
                  onTap: () {})),
          const SizedBox(width: 12),
          Expanded(
              child: _QuickActionButton(
                  icon: Icons.calendar_today_rounded,
                  label: 'Reserve',
                  color: AppColors.secondary,
                  onTap: _showReservations)),
          const SizedBox(width: 12),
          Expanded(
              child: _QuickActionButton(
                  icon: Icons.card_giftcard_rounded,
                  label: 'Rewards',
                  color: AppColors.accent,
                  onTap: _showLoyalty)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title,
          style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary)),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 8),
              Text(label,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// APP DRAWER
// ============================================================================

class AppDrawer extends StatelessWidget {
  final Function(String) onNavigate;

  const AppDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.restaurant,
                          color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 16),
                    const Text('Savoria',
                        style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('Fine Italian Cuisine',
                        style: TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    _DrawerItem(
                        icon: Icons.home_rounded,
                        label: 'Home',
                        onTap: () => Navigator.pop(context)),
                    _DrawerItem(
                        icon: Icons.shopping_bag_rounded,
                        label: 'My Cart',
                        onTap: () => onNavigate('cart')),
                    _DrawerItem(
                        icon: Icons.history_rounded,
                        label: 'Order History',
                        onTap: () {}),
                    _DrawerItem(
                        icon: Icons.calendar_today_rounded,
                        label: 'Reservations',
                        onTap: () => onNavigate('reservations')),
                    _DrawerItem(
                        icon: Icons.card_giftcard_rounded,
                        label: 'Loyalty & Rewards',
                        onTap: () => onNavigate('loyalty')),
                    const Divider(height: 32),
                    _DrawerItem(
                        icon: Icons.person_outline_rounded,
                        label: 'Profile',
                        onTap: () => onNavigate('profile')),
                    _DrawerItem(
                        icon: Icons.settings_rounded,
                        label: 'Settings',
                        onTap: () {}),
                    _DrawerItem(
                        icon: Icons.help_outline_rounded,
                        label: 'Help & Support',
                        onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(label,
          style: const TextStyle(fontSize: 16, color: AppColors.textPrimary)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

// ============================================================================
// PROMOTIONS BANNER
// ============================================================================

class PromotionsBanner extends StatefulWidget {
  const PromotionsBanner({super.key});

  @override
  State<PromotionsBanner> createState() => _PromotionsBannerState();
}

class _PromotionsBannerState extends State<PromotionsBanner> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % SampleData.promotions.length;
        _pageController.animateToPage(nextPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: SampleData.promotions.length,
            itemBuilder: (context, index) {
              final promo = SampleData.promotions[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: promo['gradient'],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: (promo['gradient'][0] as Color).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(promo['title'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(promo['subtitle'],
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14)),
                          ],
                        ),
                      ),
                      Icon(promo['icon'],
                          color: Colors.white.withOpacity(0.3), size: 64),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            SampleData.promotions.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.primary
                      : AppColors.textLight,
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// POPULAR ITEMS SECTION
// ============================================================================

class PopularItemsSection extends StatelessWidget {
  final List<MenuItem> items;
  final Function(MenuItem) onItemTap;

  const PopularItemsSection(
      {super.key, required this.items, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onItemTap(item),
            child: Container(
              width: 180,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        child: Image.network(
                          item.imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                              height: 120,
                              color: AppColors.textLight.withOpacity(0.3),
                              child: const Icon(Icons.restaurant,
                                  size: 40, color: AppColors.textLight)),
                        ),
                      ),
                      if (item.tags.isNotEmpty)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(item.tags.first,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.starYellow, size: 16),
                            const SizedBox(width: 4),
                            Text('${item.rating}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14)),
                            Text(' (${item.reviewCount})',
                                style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('\$${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// MENU CATEGORIES SECTION
// ============================================================================

class MenuCategoriesSection extends StatefulWidget {
  final Function(MenuItem) onItemTap;

  const MenuCategoriesSection({super.key, required this.onItemTap});

  @override
  State<MenuCategoriesSection> createState() => _MenuCategoriesSectionState();
}

class _MenuCategoriesSectionState extends State<MenuCategoriesSection> {
  String _selectedCategory = 'All';

  List<MenuItem> get _filteredItems {
    if (_selectedCategory == 'All') return SampleData.menuItems;
    return SampleData.menuItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: SampleData.categories.length,
            itemBuilder: (context, index) {
              final category = SampleData.categories[index];
              final isSelected = category == _selectedCategory;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) =>
                      setState(() => _selectedCategory = category),
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal),
                  backgroundColor: Colors.white,
                  side: BorderSide(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            final item = _filteredItems[index];
            return GestureDetector(
              onTap: () => widget.onItemTap(item),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (c, e, s) => Container(
                            width: 80,
                            height: 80,
                            color: AppColors.textLight.withOpacity(0.3),
                            child: const Icon(Icons.restaurant,
                                color: AppColors.textLight)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(item.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis)),
                              if (item.isVegetarian)
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: const Icon(Icons.eco,
                                        color: Colors.green, size: 14)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(item.description,
                              style: const TextStyle(
                                  fontSize: 14, color: AppColors.textSecondary),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('\$${item.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary)),
                              Row(children: [
                                const Icon(Icons.star,
                                    color: AppColors.starYellow, size: 16),
                                const SizedBox(width: 4),
                                Text('${item.rating}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary))
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ============================================================================
// OFFERS SECTION
// ============================================================================

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.secondary, AppColors.secondary.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Text('LIMITED TIME',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary)),
                ),
                const SizedBox(height: 12),
                const Text('First Order\n30% OFF',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2)),
                const SizedBox(height: 8),
                Text('Use code: WELCOME30',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 14)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.secondary),
            child: const Text('Claim'),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// REVIEWS SECTION
// ============================================================================

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: SampleData.reviews.length,
        itemBuilder: (context, index) {
          final review = SampleData.reviews[index];
          return Container(
            width: 300,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(review.avatarUrl),
                        child: const Icon(Icons.person, size: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.userName,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Row(
                              children: List.generate(
                                  5,
                                  (i) => Icon(
                                      i < review.rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: AppColors.starYellow,
                                      size: 16))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                    child: Text('"${review.comment}"',
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// CONTACT SECTION
// ============================================================================

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Visit Us',
              style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 10)
                    ]),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.location_on, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text('Open in Maps',
                      style: TextStyle(fontWeight: FontWeight.w600))
                ]),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _ContactInfoTile(
              icon: Icons.location_on_outlined,
              title: 'Address',
              subtitle: 'Hrasnicka Cesta 15, Sarajevo, BH 71000'),
          _ContactInfoTile(
              icon: Icons.phone_outlined,
              title: 'Phone',
              subtitle: '+387 (625) 36 604'),
          _ContactInfoTile(
              icon: Icons.access_time_outlined,
              title: 'Hours',
              subtitle: 'Mon-Sun: 11:00 AM - 11:00 PM'),
          _ContactInfoTile(
              icon: Icons.email_outlined,
              title: 'Email',
              subtitle: 'kareem@savoria.com'),
        ],
      ),
    );
  }
}

class _ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ContactInfoTile(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ITEM DETAIL SHEET
// ============================================================================

class ItemDetailSheet extends StatefulWidget {
  final MenuItem item;
  final Function(int quantity, String? instructions) onAddToCart;

  const ItemDetailSheet(
      {super.key, required this.item, required this.onAddToCart});

  @override
  State<ItemDetailSheet> createState() => _ItemDetailSheetState();
}

class _ItemDetailSheetState extends State<ItemDetailSheet> {
  int _quantity = 1;
  final TextEditingController _instructionsController = TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        children: [
          Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2))),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.item.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                        height: 250,
                        color: AppColors.textLight.withOpacity(0.3),
                        child: const Icon(Icons.restaurant,
                            size: 60, color: AppColors.textLight)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(widget.item.name,
                                    style: const TextStyle(
                                        fontFamily: 'Georgia',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600))),
                            Text('\$${widget.item.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontFamily: 'Georgia',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.starYellow, size: 20),
                            const SizedBox(width: 4),
                            Text('${widget.item.rating}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text(' (${widget.item.reviewCount} reviews)',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary)),
                            if (widget.item.isVegetarian) ...[
                              const SizedBox(width: 12),
                              const Icon(Icons.eco,
                                  color: Colors.green, size: 18),
                              const SizedBox(width: 4),
                              const Text('Vegetarian',
                                  style: TextStyle(color: Colors.green))
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(widget.item.description,
                            style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                                height: 1.5)),
                        if (widget.item.tags.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.item.tags
                                .map((tag) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                          color: AppColors.primary
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(tag,
                                          style: const TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w500)),
                                    ))
                                .toList(),
                          ),
                        ],
                        const SizedBox(height: 20),
                        const Text('Special Instructions',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        TextField(
                            controller: _instructionsController,
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: 'Any allergies or preferences?',
                                hintStyle:
                                    TextStyle(color: AppColors.textLight))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4))
            ]),
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _quantity > 1
                                ? () => setState(() => _quantity--)
                                : null),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text('$_quantity',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => setState(() => _quantity++)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => widget.onAddToCart(
                          _quantity,
                          _instructionsController.text.isEmpty
                              ? null
                              : _instructionsController.text),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: Text(
                          'Add to Cart • \$${(widget.item.price * _quantity).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// CART PAGE
// ============================================================================

class CartPage extends StatefulWidget {
  final CartManager cartManager;

  const CartPage({super.key, required this.cartManager});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    widget.cartManager.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.cartManager.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _checkout() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => CheckoutSheet(cartManager: widget.cartManager));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart',
            style:
                TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
        actions: [
          if (widget.cartManager.items.isNotEmpty)
            TextButton(
                onPressed: () => widget.cartManager.clear(),
                child: const Text('Clear',
                    style: TextStyle(color: AppColors.error))),
        ],
      ),
      body: widget.cartManager.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 80, color: AppColors.textLight),
                  const SizedBox(height: 16),
                  const Text('Your cart is empty',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  const Text('Add some delicious items to get started',
                      style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Browse Menu')),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.cartManager.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = widget.cartManager.items[index];
                      return Dismissible(
                        key: Key(cartItem.item.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) =>
                            widget.cartManager.removeItem(cartItem.item.id),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Icon(Icons.delete_outline,
                              color: Colors.white),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2))
                              ]),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(cartItem.item.imageUrl,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => Container(
                                          width: 70,
                                          height: 70,
                                          color: AppColors.textLight
                                              .withOpacity(0.3),
                                          child: const Icon(Icons.restaurant,
                                              color: AppColors.textLight)))),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cartItem.item.name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(
                                        '\$${cartItem.item.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: AppColors.primary)),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                        onTap: () => widget.cartManager
                                            .updateQuantity(cartItem.item.id,
                                                cartItem.quantity - 1),
                                        child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child:
                                                Icon(Icons.remove, size: 18))),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text('${cartItem.quantity}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600))),
                                    InkWell(
                                        onTap: () => widget.cartManager
                                            .updateQuantity(cartItem.item.id,
                                                cartItem.quantity + 1),
                                        child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Icon(Icons.add, size: 18))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4))
                  ]),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Subtotal',
                                  style: TextStyle(
                                      color: AppColors.textSecondary)),
                              Text(
                                  '\$${widget.cartManager.subtotal.toStringAsFixed(2)}')
                            ]),
                        const SizedBox(height: 8),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tax (8%)',
                                  style: TextStyle(
                                      color: AppColors.textSecondary)),
                              Text(
                                  '\$${widget.cartManager.tax.toStringAsFixed(2)}')
                            ]),
                        const Divider(height: 24),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  '\$${widget.cartManager.total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary))
                            ]),
                        const SizedBox(height: 16),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _checkout,
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16)),
                                child: const Text('Proceed to Checkout',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// ============================================================================
// CHECKOUT SHEET
// ============================================================================

class CheckoutSheet extends StatefulWidget {
  final CartManager cartManager;

  const CheckoutSheet({super.key, required this.cartManager});

  @override
  State<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends State<CheckoutSheet> {
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  String _selectedPayment = 'card';

  void _processOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isProcessing = true);
      await Future.delayed(const Duration(seconds: 2));
      widget.cartManager.clear();
      if (mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.check_circle,
                        color: AppColors.success, size: 50)),
                const SizedBox(height: 20),
                const Text('Order Confirmed!',
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 24,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                    'Your order #${DateTime.now().millisecondsSinceEpoch % 10000} has been placed.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Done'))),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        children: [
          Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2))),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                const Text('Checkout',
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 24,
                        fontWeight: FontWeight.w600))
              ])),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Delivery Details',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person_outline)),
                        validator: (v) =>
                            v?.isEmpty ?? true ? 'Required' : null),
                    const SizedBox(height: 12),
                    TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone_outlined)),
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            v?.isEmpty ?? true ? 'Required' : null),
                    const SizedBox(height: 12),
                    TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Delivery Address',
                            prefixIcon: Icon(Icons.location_on_outlined)),
                        maxLines: 2,
                        validator: (v) =>
                            v?.isEmpty ?? true ? 'Required' : null),
                    const SizedBox(height: 24),
                    const Text('Payment Method',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _PaymentOption(
                        icon: Icons.credit_card,
                        label: 'Credit/Debit Card',
                        value: 'card',
                        groupValue: _selectedPayment,
                        onChanged: (v) =>
                            setState(() => _selectedPayment = v!)),
                    _PaymentOption(
                        icon: Icons.account_balance_wallet,
                        label: 'Digital Wallet',
                        value: 'wallet',
                        groupValue: _selectedPayment,
                        onChanged: (v) =>
                            setState(() => _selectedPayment = v!)),
                    _PaymentOption(
                        icon: Icons.money,
                        label: 'Cash on Delivery',
                        value: 'cash',
                        groupValue: _selectedPayment,
                        onChanged: (v) =>
                            setState(() => _selectedPayment = v!)),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal',
                                    style: TextStyle(
                                        color: AppColors.textSecondary)),
                                Text(
                                    '\$${widget.cartManager.subtotal.toStringAsFixed(2)}')
                              ]),
                          const SizedBox(height: 8),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tax (8%)',
                                    style: TextStyle(
                                        color: AppColors.textSecondary)),
                                Text(
                                    '\$${widget.cartManager.tax.toStringAsFixed(2)}')
                              ]),
                          const SizedBox(height: 8),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Delivery',
                                    style: TextStyle(
                                        color: AppColors.textSecondary)),
                                const Text('\$5.00')
                              ]),
                          const Divider(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    '\$${(widget.cartManager.total + 5).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary))
                              ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4))
            ]),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _processOrder,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Text(
                          'Place Order • \$${(widget.cartManager.total + 5).toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String groupValue;
  final Function(String?) onChanged;

  const _PaymentOption(
      {required this.icon,
      required this.label,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color:
                isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: isSelected ? 2 : 1)),
        child: Row(children: [
          Icon(icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
          if (isSelected)
            const Icon(Icons.check_circle, color: AppColors.primary)
        ]),
      ),
    );
  }
}

// ============================================================================
// RESERVATION PAGE
// ============================================================================

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 19, minute: 0);
  int _guests = 2;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _selectDate() async {
    final date = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)),
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: AppColors.primary)),
            child: child!));
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: AppColors.primary)),
            child: child!));
    if (time != null) setState(() => _selectedTime = time);
  }

  void _submitReservation() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _isSubmitting = false);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.calendar_today,
                        color: AppColors.success, size: 40)),
                const SizedBox(height: 20),
                const Text('Reservation Confirmed!',
                    style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 24,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                    'We look forward to seeing you on ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} at ${_selectedTime.format(context)}.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Done'))),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Make a Reservation',
              style: TextStyle(
                  fontFamily: 'Georgia', fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark]),
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  children: [
                    Icon(Icons.restaurant, color: Colors.white, size: 40),
                    SizedBox(width: 16),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Reserve Your Table',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(
                              'Secure your spot for an unforgettable experience',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 14))
                        ])),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Date & Time',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: _SelectionTile(
                          icon: Icons.calendar_today,
                          label: 'Date',
                          value:
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          onTap: _selectDate)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _SelectionTile(
                          icon: Icons.access_time,
                          label: 'Time',
                          value: _selectedTime.format(context),
                          onTap: _selectTime)),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Number of Guests',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: _guests > 1
                            ? () => setState(() => _guests--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: AppColors.primary,
                        iconSize: 32),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(children: [
                          Text('$_guests',
                              style: const TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary)),
                          const Text('guests',
                              style: TextStyle(color: AppColors.textSecondary))
                        ])),
                    IconButton(
                        onPressed: _guests < 20
                            ? () => setState(() => _guests++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                        color: AppColors.primary,
                        iconSize: 32),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Contact Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_outline)),
                  validator: (v) =>
                      v?.isEmpty ?? true ? 'Please enter your name' : null),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_outlined)),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v?.isEmpty ?? true
                      ? 'Please enter your phone number'
                      : null),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                      labelText: 'Special Requests (optional)',
                      prefixIcon: Icon(Icons.note_outlined),
                      hintText: 'Allergies, special occasions, etc.'),
                  maxLines: 3),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitReservation,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Text('Confirm Reservation',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _SelectionTile(
      {required this.icon,
      required this.label,
      required this.value,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 12))
          ]),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
        ]),
      ),
    );
  }
}

// ============================================================================
// LOYALTY PAGE
// ============================================================================

class LoyaltyPage extends StatelessWidget {
  final LoyaltyManager loyaltyManager;

  const LoyaltyPage({super.key, required this.loyaltyManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Loyalty & Rewards',
              style: TextStyle(
                  fontFamily: 'Georgia', fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(loyaltyManager.tier,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              const Text('Member',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12))
                            ]),
                        const Icon(Icons.star, color: Colors.white, size: 40)
                      ]),
                  const SizedBox(height: 20),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('${loyaltyManager.points}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text('points',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16)))
                  ]),
                  const SizedBox(height: 16),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                          value: loyaltyManager.points / 2000,
                          backgroundColor: Colors.white30,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 8)),
                  const SizedBox(height: 8),
                  Text('${2000 - loyaltyManager.points} points to Platinum',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Available Rewards',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _RewardTile(
                title: 'Free Dessert',
                points: 500,
                available: loyaltyManager.points >= 500,
                onRedeem: () {}),
            _RewardTile(
                title: '\$10 Off Your Order',
                points: 750,
                available: loyaltyManager.points >= 750,
                onRedeem: () {}),
            _RewardTile(
                title: 'Free Appetizer',
                points: 1000,
                available: loyaltyManager.points >= 1000,
                onRedeem: () {}),
            _RewardTile(
                title: 'Free Entrée',
                points: 2000,
                available: loyaltyManager.points >= 2000,
                onRedeem: () {}),
            const SizedBox(height: 24),
            const Text('How to Earn Points',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _EarnPointsTile(
                icon: Icons.restaurant,
                title: 'Dine In',
                description: '1 point per \$1 spent'),
            _EarnPointsTile(
                icon: Icons.delivery_dining,
                title: 'Online Orders',
                description: '2 points per \$1 spent'),
            _EarnPointsTile(
                icon: Icons.star,
                title: 'Leave a Review',
                description: '50 bonus points'),
            _EarnPointsTile(
                icon: Icons.person_add,
                title: 'Refer a Friend',
                description: '100 bonus points'),
          ],
        ),
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  final String title;
  final int points;
  final bool available;
  final VoidCallback onRedeem;

  const _RewardTile(
      {required this.title,
      required this.points,
      required this.available,
      required this.onRedeem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.card_giftcard, color: AppColors.accent)),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                Text('$points points',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 14))
              ])),
          ElevatedButton(
            onPressed: available ? onRedeem : null,
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    available ? AppColors.primary : Colors.grey.shade300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
            child: Text(available ? 'Redeem' : 'Locked',
                style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _EarnPointsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _EarnPointsTile(
      {required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: AppColors.primary)),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16)),
                Text(description,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 14))
              ])),
        ],
      ),
    );
  }
}

// ============================================================================
// PROFILE PAGE
// ============================================================================

class ProfilePage extends StatelessWidget {
  final LoyaltyManager loyaltyManager;

  const ProfilePage({super.key, required this.loyaltyManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Profile',
              style: TextStyle(
                  fontFamily: 'Georgia', fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 16),
            const Text('Guest User',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('guest@savoria.com',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.star, color: AppColors.accent),
                const SizedBox(width: 8),
                Text('${loyaltyManager.points} Points',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(width: 8),
                Text('• ${loyaltyManager.tier} Member',
                    style: const TextStyle(color: AppColors.textSecondary))
              ]),
            ),
            const SizedBox(height: 24),
            _ProfileOption(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {}),
            _ProfileOption(
                icon: Icons.location_on_outlined,
                title: 'Saved Addresses',
                onTap: () {}),
            _ProfileOption(
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                onTap: () {}),
            _ProfileOption(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {}),
            _ProfileOption(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {}),
            _ProfileOption(
                icon: Icons.info_outline, title: 'About', onTap: () {}),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('Sign Out'))),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileOption(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}

// ============================================================================
// SEARCH DELEGATE
// ============================================================================

class MenuSearchDelegate extends SearchDelegate<MenuItem?> {
  final List<MenuItem> menuItems;
  final Function(MenuItem) onItemSelected;

  MenuSearchDelegate({required this.menuItems, required this.onItemSelected});

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    final results = menuItems
        .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                      width: 50,
                      height: 50,
                      color: AppColors.textLight.withOpacity(0.3),
                      child: const Icon(Icons.restaurant)))),
          title: Text(item.name),
          subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.star, color: AppColors.starYellow, size: 16),
            Text(' ${item.rating}')
          ]),
          onTap: () {
            close(context, item);
            onItemSelected(item);
          },
        );
      },
    );
  }
}
