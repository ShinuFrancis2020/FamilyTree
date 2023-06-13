import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<String> imagePaths = [
    "assets/images/gallery/g1.png",
    "assets/images/gallery/g2.png",
    "assets/images/gallery/g3.png",
    "assets/images/gallery/g4.png",
    "assets/images/gallery/g5.png",
    "assets/images/gallery/g6.png",
    "assets/images/gallery/g7.png",
    "assets/images/gallery/g8.png",
    "assets/images/gallery/g9.png"

    // Add more image paths here...
  ];

  GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: GridView.builder(
          itemCount: imagePaths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Set the number of columns in the grid
            crossAxisSpacing: 10.0, // Set the spacing between columns
            mainAxisSpacing: 10.0, // Set the spacing between rows
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Handle image tap event
                // You can navigate to a detailed view or perform any action
                // related to the tapped image.
                print('Tapped image at index: $index');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
