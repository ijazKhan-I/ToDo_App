class ToDo{

  int? id;
  late String title;
  late String note;
  late String date;


  ToDo({this.id, required this.title,required this.note,required this.date});


Map<String,dynamic> todoMap(){
  return{
    "id":id,
    "title":title,
    "note":note,
    "date":date,
  };
}
  ToDo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    note = map['note'];
    date= map['date'];
  }


}