import 'package:apiproject/todo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'add_screen.dart';
import 'db_screen.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
@override
void initState() {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey),
          ),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
          }, child: Text("Add Task",style: TextStyle(
              fontSize: MediaQuery.of(context).devicePixelRatio*7
          ),)),
        ],
        title:  Center(child: Text("To Do App",style: TextStyle(
            fontSize: MediaQuery.of(context).devicePixelRatio*9
        ),)),
      ),

      body:OrientationBuilder(builder: (BuildContext context, Orientation orientation){
        if(orientation==Orientation.portrait)
        {
         return FutureBuilder<List<ToDo>>(
              future: DatabaseHelper.instance.read(),
              builder: (BuildContext context, AsyncSnapshot<List<ToDo>> snapshot){
                if(!snapshot.hasData)
                {
                  return const Center(child: CircularProgressIndicator());
                }else{
                  if(snapshot.data!.isEmpty)
                  {
                    return const Center(child: Text("No Record"));
                  }else{
                    List<ToDo> todo=snapshot.data!;
                    return Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio*6),
                      child: ListView.builder(

                          itemCount: todo.length,
                          itemBuilder:
                              (context, index){
                            ToDo Todo= todo[index];
                            return InkWell(
                              onTap: (){
                                showDialog(
                                    barrierDismissible: false,
                                    context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: Text("${Todo.title}\n\n${Todo.note}\n\n${Todo.date}",style: TextStyle(
                                        fontSize: MediaQuery.of(context).devicePixelRatio*7
                                    ),),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: Text("close",style: TextStyle(
                                          fontSize: MediaQuery.of(context).devicePixelRatio*7
                                      ),)),

                                    ],
                                  );
                                });

                              }, child:Container(


                              height:MediaQuery.of(context).size.height/13,
                              margin:  EdgeInsets.all( MediaQuery.of(context).devicePixelRatio*3),
                              padding:  EdgeInsets.only(left: MediaQuery.of(context).devicePixelRatio*10),

                              decoration: BoxDecoration(

                                  color: Colors.green[500],
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                                  boxShadow:  [
                                    BoxShadow(

                                      spreadRadius:MediaQuery.of(context).devicePixelRatio*1 ,
                                      blurRadius: MediaQuery.of(context).devicePixelRatio*3,
                                      offset: Offset(MediaQuery.of(context).devicePixelRatio*0, MediaQuery.of(context).devicePixelRatio*1),

                                    )
                                  ]
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text("\n${ Todo.title}", style: TextStyle(fontSize: MediaQuery.of(context).devicePixelRatio*7),),

                                      ],
                                    ),
                                  ),
                                  Container(

                                    child: Column(

                                      children: [

                                        IconButton(onPressed: (){
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context, builder: (context){

                                            return  AlertDialog(

                                              title: Text("Confirmation!",style: TextStyle(
                                                  fontSize: MediaQuery.of(context).devicePixelRatio*7
                                              ),),
                                              content: Text("Are you Sure to delete Record?",style: TextStyle(
                                                  fontSize: MediaQuery.of(context).devicePixelRatio*7
                                              ),),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                }, child: Text("NO",style: TextStyle(
                                                    fontSize: MediaQuery.of(context).devicePixelRatio*7
                                                ),)),
                                                TextButton(onPressed: () async{
                                                  Navigator.of(context).pop();
                                                  int result=  await DatabaseHelper.instance.delete(Todo.id!);
                                                  if(result>0){
                                                    Fluttertoast.showToast(msg: "Delete Record");
                                                  }
                                                  setState(() {});
                                                }, child: Text("Yes",style: TextStyle(
                                                    fontSize: MediaQuery.of(context).devicePixelRatio*7
                                                ),)),
                                              ],
                                            );
                                          });
                                        }, icon: Icon(Icons.delete,size:MediaQuery.of(context).devicePixelRatio*9,)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            );
                          }),
                    );
                  }
                }
              });
        }else{
         return FutureBuilder<List<ToDo>>(
              future: DatabaseHelper.instance.read(),
              builder: (BuildContext context, AsyncSnapshot<List<ToDo>> snapshot){
                if(!snapshot.hasData)
                {
                  return const Center(child: CircularProgressIndicator());
                }else{
                  if(snapshot.data!.isEmpty)
                  {
                    return const Center(child: Text("No Record"));
                  }else{
                    List<ToDo> todo=snapshot.data!;
                    return Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).devicePixelRatio*6),
                      child: ListView.builder(

                          itemCount: todo.length,
                          itemBuilder:
                              (context, index){
                            ToDo Todo= todo[index];
                            return InkWell(
                              onTap: (){
                                showDialog(
                                    barrierDismissible: false,
                                    context: context, builder: (context){
                                  return  AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: Text("${Todo.title}\n\n${Todo.note}\n\n${Todo.date}",style: TextStyle(
                                        fontSize: MediaQuery.of(context).devicePixelRatio*7
                                    ),),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: Text("close",style: TextStyle(
                                          fontSize: MediaQuery.of(context).devicePixelRatio*7
                                      ),)),

                                    ],
                                  );
                                });

                              }, child:Container(


                              height:MediaQuery.of(context).size.height/6,
                              margin:  EdgeInsets.all( MediaQuery.of(context).devicePixelRatio*3),
                              padding:  EdgeInsets.only(left: MediaQuery.of(context).devicePixelRatio*10),

                              decoration: BoxDecoration(

                                  color: Colors.green[500],
                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).devicePixelRatio*6),
                                  boxShadow:  [
                                    BoxShadow(
                                      spreadRadius:MediaQuery.of(context).devicePixelRatio*1 ,
                                      blurRadius: MediaQuery.of(context).devicePixelRatio*3,
                                      offset: Offset(MediaQuery.of(context).devicePixelRatio*0, MediaQuery.of(context).devicePixelRatio*1),

                                    )
                                  ]
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text("\n${ Todo.title}", style: TextStyle(fontSize: MediaQuery.of(context).devicePixelRatio*7),),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        IconButton(onPressed: (){
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context, builder: (context){
                                            return  AlertDialog(
                                              title: Text("Confirmation!",style: TextStyle(
                                                  fontSize: MediaQuery.of(context).devicePixelRatio*7
                                              ),),
                                              content: Text("Are you Sure to delete Record?",style: TextStyle(
                                                  fontSize: MediaQuery.of(context).devicePixelRatio*7
                                              ),),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                }, child: Text("NO",style: TextStyle(
                                                    fontSize: MediaQuery.of(context).devicePixelRatio*7
                                                ),)),
                                                TextButton(onPressed: () async{
                                                  Navigator.of(context).pop();
                                                  int result=  await DatabaseHelper.instance.delete(Todo.id!);
                                                  if(result>0){
                                                    Fluttertoast.showToast(msg: "Delete Record");
                                                  }
                                                  setState(() {});
                                                }, child: Text("Yes",style: TextStyle(
                                                    fontSize: MediaQuery.of(context).devicePixelRatio*7
                                                ),)),
                                              ],
                                            );
                                          });
                                        }, icon: Icon(Icons.delete,size:MediaQuery.of(context).devicePixelRatio*9,)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            );
                          }),
                    );
                  }
                }
              });
        }
      }),
    );
  }
}
