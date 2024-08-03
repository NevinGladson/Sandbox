import 'package:flutter/material.dart';

class TemplateTab extends StatelessWidget {
  const TemplateTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust this number to control how many cards per row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 3 / 2, // Adjust the aspect ratio as needed
        ),
        itemCount: 3, // The number of templates
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Template ${index + 1}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Image.asset('assets/template${index + 1}.jpg'), // Ensure you have these assets in your project
              ],
            ),
          );
        },
      ),
    );
  }
}
