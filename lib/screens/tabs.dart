import 'package:demo_app/providers/favorites_provider.dart';
import 'package:demo_app/providers/filters_provider.dart';
import 'package:demo_app/screens/categories.dart';
import 'package:demo_app/screens/filters.dart';
import 'package:demo_app/screens/meals.dart';
import 'package:demo_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _currentIndex = 0;

  void _changeScreen(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final availableMeals = ref.watch(filterMealsProvider);
    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );

    var title = "Categories";

    if (_currentIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
        title: "",
      );
      title = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
    );
  }
}
