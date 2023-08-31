import 'package:flutter/material.dart';

class Activity {
  final String name;
  final Category category;

  Activity({
    required this.name,
    required this.category,
  });
}

class Category {
  final String name;
  final IconData icon;

  Category({
    required this.name,
    required this.icon,
  });
}

List<Category> categories = [
  Category(name: 'Sports', icon: Icons.sports_soccer),
  Category(name: 'Arts', icon: Icons.brush),
  Category(name: 'Cooking', icon: Icons.restaurant),
  Category(name: 'Outdoors', icon: Icons.nature_people),
];


List<Activity> dummyActivities = [
  Activity(name: 'Basketball', category: categories[0]),
  Activity(name: 'Yoga', category: categories[0]),
  Activity(name: 'Painting', category: categories[1]),
  Activity(name: 'Dance', category: categories[1]),
  Activity(name: 'Cooking Class', category: categories[2]),
  Activity(name: 'Nature Walk', category: categories[3]),
  Activity(name: 'Music', category: categories[1]),
  Activity(name: 'Photography', category: categories[1]),
  Activity(name: 'Swimming', category: categories[0]),
  Activity(name: 'Football', category: categories[0]),
];



