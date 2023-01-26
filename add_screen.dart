import 'package:apiproject/db_screen.dart';
import 'package:apiproject/home_screen.dart';
import 'package:apiproject/todo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  var formkey=GlobalKey<FormState> ();
  late String title,note,date;
 var titleController=TextEditingController();
 var noteController=TextEditingController();
 late DateTime dateTime;
  TextEditingController DateController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Add new task",style: TextStyle(
            fontSize: MediaQuery.of(context).devicePixelRatio*9
        ),),
      ),
      body:Padding(
        padding:  EdgeInsets.all( MediaQuery.of(context).devicePixelRatio*4,),
        child: Form(
          key: formkey,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Title",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).devicePixelRatio*10,
                ),),


                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*30,
                  width: MediaQuery.of(context).devicePixelRatio*165,
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: "Enter title here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Enter title please!";
                      }

                      else {
                        title = text.toString();
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*4,
                ),
                Text("Note",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).devicePixelRatio*10,
                ),),

                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*80,
                  width: MediaQuery.of(context).devicePixelRatio*165,
                  child: TextFormField(
                    maxLength: 50,
                    controller: noteController,
                   maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: "Enter note here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return "Enter note please!";
                      }

                      else {
                        note = text.toString();

                      }
                    },
                  ),
                ),
                 SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*0,
                ),
                Text("Date",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).devicePixelRatio*10,
                ),),
                SizedBox(
                  height: MediaQuery.of(context).devicePixelRatio*30,
                  width: MediaQuery.of(context).devicePixelRatio*165,
                  child: TextFormField(
                    controller: DateController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Enter date",
                        prefix: IconButton(onPressed: ()async{

                          DateTime?  datepicker= await showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022), lastDate: DateTime(2035));
                           if(datepicker != null  ) {
                             TimeOfDay? pickedTime = await showTimePicker(
                               initialTime: TimeOfDay.now(),
                               context: context,
                             );


                             if (pickedTime != null) {
                               DateTime parsedTime = DateFormat.jm().parse(
                                   pickedTime.format(context).toString());
                               String formattedTime = DateFormat('HH:mm').format(
                                   parsedTime);
                               String formattedDate = DateFormat(
                                   'yyyy-MM-dd $formattedTime').format(
                                   datepicker);
                               setState(() {
                                 DateController.text = formattedDate.toString();
                                 dateTime = DateTime.parse(
                                     formattedDate);

                               });
                             }
                           }



    }, icon: Icon(Icons.calendar_month),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    validator: (String? text) {
                      if (text == null || text.isEmpty ) {
                        return "enter date please!";
                      }

                      else {
                        date = text.toString();

                      }
                    },
                  ),
                ),
                SizedBox(
                  height:  MediaQuery.of(context).devicePixelRatio*4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {


                            ToDo Tasktodo= ToDo(
                              title: title,
                              note: note,
                              date: date,

                            );
                            int result= await DatabaseHelper.instance.addTask(Tasktodo);

                            if(result>0){

                              Fluttertoast.showToast(msg: "Record added");
                              final Event event = Event(
                                title: titleController.text.toString(),
                                description: noteController.text.toString(),
                                location: 'Event location',
                                startDate: dateTime,
                                endDate: dateTime,
                              );
                              Add2Calendar.addEvent2Cal(event);
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            }

                            else{
                              Fluttertoast.showToast(msg: "Record failed" );
                            }
                          } else {

                          }
                        },
                        child: const Text("Add task")),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
