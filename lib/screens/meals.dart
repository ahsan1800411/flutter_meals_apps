import 'package:demo_app/models/meal.dart';
import 'package:demo_app/screens/meals_details_screen.dart';
import 'package:demo_app/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title;
  final List<Meal> meals;

  void onSelectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Uh oh! No meals found....',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    )),
            const SizedBox(height: 16),
            Text(
              'Try changing your Category.',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: title!.isNotEmpty
          ? AppBar(
              title: Text(
                title!,
              ),
            )
          : null,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            meal: meals[index],
            onMealSelected: (meal) {
              onSelectMeal(context, meal);
            },
          );
        },
        itemCount: meals.length,
      ),
    );
  }
}
