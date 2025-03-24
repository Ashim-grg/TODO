import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final String category;
  final int number;

  const CategoryList({super.key, required this.category, required this.number});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  double progress = 0.0;

  void increaseProgress() {
    setState(() {
      progress = (progress + 0.2).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 5), 
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(8, 25, 83, 1),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade800,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 4), 
          ),
           BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, -4), 
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.number} tasks',
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            widget.category,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10), // Adjusted spacing
          GestureDetector(
            onTap: increaseProgress,
            child: SizedBox(
              height: 4,
              width: double.infinity,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20),
                value: progress,
                backgroundColor: Colors.grey.shade800,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}