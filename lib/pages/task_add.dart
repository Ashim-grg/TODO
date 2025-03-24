import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class TaskAdd extends StatefulWidget {
  const TaskAdd({super.key});

  @override
  State<TaskAdd> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  TextEditingController taskController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  late DateTime selectedDate;
  late DateTime focusedDate;
  @override
  void initState() {
    selectedDate = DateTime.now();
    focusedDate = DateTime.now();
    super.initState();
  }

  void addsuccess() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Adding Task'),
        content: Text('Please wait...'),
      );
    },
  );

  Future.delayed(Duration(seconds: 3), () {
    Navigator.of(context).pop();
    showDialog(
      // ignore: use_build_context_synchronously
      context: (context),
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Task Added Successfully'),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/home');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  });
}


  Future<void> selectDate() async{
    showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          child: SizedBox(
            height: 480,
                width: 400,
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: focusedDate, 
                  firstDay: DateTime.utc(2020,1,1), 
                  lastDay: DateTime.utc(2025,12,31),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay){
                    setState(() {
                      selectedDate = selectedDay;
                      focusedDate = focusedDay;
                    });
                  },
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical:15),
                      alignment: Alignment.center,
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text('Select'),
                    )),
                )
              ],
            ),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           context.go('/home');
          },
        ),
      ),
      body: GestureDetector(
        onTap: (){
              setState(() {
                focusNode1.unfocus();
                focusNode2.unfocus();
              });
            },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Tasks',
              style: GoogleFonts.dmSerifText(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600
              ),),
              SizedBox(height: 10,),
              TextField(
              focusNode: focusNode1,
              controller: taskController,
              autocorrect: false,
              decoration: InputDecoration(
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(15)
        
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.black)
                ),
                contentPadding: const EdgeInsets.only(left: 10),
                hintText: 'Task.....',
                hintStyle: GoogleFonts.dmSerifText(
                  color: Colors.grey.shade500,
                  fontSize: 15
                ),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      taskController.clear();
                    });
                  }, 
                  icon: Icon(Icons.clear,size: 20,color: Colors.grey,))
              ),
            ),
              SizedBox(height: 20,),
              TextField(
                focusNode: focusNode2,
                controller: detailsController,
                maxLines: 6,
                decoration: InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  contentPadding: const EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 20),
                  hintText: 'Details.....',
                  hintStyle: GoogleFonts.dmSerifText(
                    color: Colors.grey.shade500,
                    fontSize: 15
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        detailsController.clear();
                      });
                    }, 
                    icon: Icon(Icons.clear,size: 20,color: Colors.grey,))
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: selectDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade500),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 10,),
                      Text('Select Date',
                      style: GoogleFonts.dmSerifText(
                        fontSize: 20,
                        color: Colors.grey.shade600
                      ),
                    ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical:15),
                alignment: Alignment.center,
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey)
                ),
                child: GestureDetector(
                  onTap: addsuccess,
                  child: Text('Add Task',
                  style: GoogleFonts.dmSerifText(fontSize: 20),)),
              ),
            ],
          ),
        ),
      ),
      );
  }
}