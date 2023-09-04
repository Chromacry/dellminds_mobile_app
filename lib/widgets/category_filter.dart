import 'package:flutter/material.dart';

class CategoryFilterWidget extends StatefulWidget {
  final Function(String) onCategorySelected;

  CategoryFilterWidget({required this.onCategorySelected});

  @override
  _CategoryFilterWidgetState createState() => _CategoryFilterWidgetState();
}

class _CategoryFilterWidgetState extends State<CategoryFilterWidget> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      
        DropdownButton<String>(
          value: selectedCategory,
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue!;
              widget.onCategorySelected(selectedCategory);
            });
          },
          items: [
            DropdownMenuItem(
              value: 'All',
              child: Text('All Categories'),
            ),
            DropdownMenuItem(
              value: 'Sports',
              child: Text('Sports'),
            ),
            DropdownMenuItem(
              value: 'Arts',
              child: Text('Arts'),
            ),
            DropdownMenuItem(
              value: 'Outdoors',
              child: Text('Outdoors'),
            ),
            
            // Add more categories as needed
          ],
          
        ),
        
      ],
    );
  }
}
