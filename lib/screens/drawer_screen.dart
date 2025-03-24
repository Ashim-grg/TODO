import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_bloc/components/chart_ui.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  double progress = 2.0; // Initial border thickness

  void increaseProgress() {
    setState(() {
      if (progress < 10) progress += 2; // Increase border thickness
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width:MediaQuery.of(context).size.width, 
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Color.fromRGBO(8, 25, 83, 1), 
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 120,left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 1500),
                builder: (context,  value, child) {
                  return Container(
                    padding: EdgeInsets.all(value),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:Border.all(color: Colors.white,width: value,style: BorderStyle.solid),
                    ),
                    child: ClipOval(
                      child: Container(
                      height: 150,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/women.webp'),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle
                      ),
                                        ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Olivia',style: GoogleFonts.dmSerifText(fontSize: 40,color: Colors.white,),),
                  Text('Mitchell',style: GoogleFonts.dmSerifText(fontSize: 40,color: Colors.white,),),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero, 
                        leading: Icon(Icons.home, color: Colors.white),
                        title: Text(
                          'Home',
                          style: GoogleFonts.dmSerifText(fontSize: 20, color: Colors.white),
                        ),
                        onTap: () {
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero, 
                        leading: Icon(Icons.settings, color: Colors.white),
                        title: Text(
                          'Settings',
                          style: GoogleFonts.dmSerifText(fontSize: 20, color: Colors.white),
                        ),
                        onTap: () {
                        },
                      ),
                    ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 200,
                          child: ChartUi()
                          ),
                          SizedBox(height: 20,),
                          Text('Good',style: GoogleFonts.dmSerifText(fontSize: 20,color: Colors.grey.shade800),),
                          Text('Consistency',style: GoogleFonts.dmSerifText(fontSize: 30,color: Colors.white),),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
  }
}
