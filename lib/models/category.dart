class Category {
  final String category;
  final int number;

  Category({required this.category, required this.number});

  static List<Category> tasksCategory = [
    Category(category: 'Work', number: 5),
    Category(category: 'Personal', number: 3),
    Category(category: 'Shopping', number: 2),
    Category(category: 'Others', number: 1),
  ];
}