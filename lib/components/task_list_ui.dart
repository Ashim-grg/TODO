import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskListUi extends StatefulWidget {
  final String text;
  final bool ischecked;
  final Function(bool?) onChanged;  
  const TaskListUi({super.key, required this.ischecked,required this.onChanged,required this.text});

  @override
  State<TaskListUi> createState() => _TaskListUiState();
}

class _TaskListUiState extends State<TaskListUi> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 80,
        padding: EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromRGBO(8, 25, 83, 1),
        ),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                value: widget.ischecked, 
                onChanged: widget.onChanged
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.text,
                style: GoogleFonts.dmSerifText(fontSize: 18, color: Colors.white),
                overflow: TextOverflow.ellipsis, // This will handle long text gracefully
                softWrap: false,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
              onPressed: (){
      
              }, 
              icon: Icon(Icons.delete,color: Colors.white,)
            ),
            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.edit,color: Colors.white,))
      
              ],
            )
          ],
        ),
      ),
    );
  }
}
