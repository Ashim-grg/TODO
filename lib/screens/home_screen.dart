import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_bloc/components/category_list.dart';
import 'package:todo_bloc/components/task_list_ui.dart';
import 'package:todo_bloc/models/category.dart'; // Ensure this import is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerOpen = false;
  List<bool> isCheckedList = [false, false, false, false, false];   
  double xOffset = 0.0;
  double yOffset = 0.0;
  double scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AnimatedContainer(
        height: height,
        width: width,
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? 0.5 : 0),
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(58, 78, 156, 1),
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
        ),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (isDrawerOpen) {
                          xOffset = 0;
                          yOffset = 0;
                          scaleFactor = 1;
                          isDrawerOpen = false;
                        } else {
                          xOffset = 230;
                          yOffset = 150;
                          scaleFactor = 0.6;
                          isDrawerOpen = true;
                        }
                      });
                    },
                    icon: Icon(
                      isDrawerOpen ? Icons.arrow_back_ios : Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search, color: Colors.white)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
              SizedBox(
                    height: height * 0.32, 
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What's up, Olivia!",
                            style: GoogleFonts.dmSerifText(fontSize: 40, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'CATEGORIES',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 140,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Category.tasksCategory.length,
                              itemBuilder: (context, index) {
                                final category = Category.tasksCategory[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                  child: CategoryList(
                                    category: category.category,
                                    number: category.number,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 2),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "TODAY'S TASK",
                          style: GoogleFonts.dmSerifText(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 2),
                      ),
                    ],
                  ),
              Expanded(
                  child: ListView.builder(
                    shrinkWrap: true, 
                    itemCount: 5,
                    itemBuilder: (context,index){
                      return TaskListUi(
                        ischecked: isCheckedList[index],
                        onChanged: (value){
                          setState(() {
                            isCheckedList[index] = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
          ],
        ),
      );
  }
}