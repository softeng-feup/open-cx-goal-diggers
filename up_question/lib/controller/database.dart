import 'package:firebase_database/firebase_database.dart';
import 'package:up_question/model/Talk.dart';


class DataTalk {
  String title, room;
  int hour;

  DataTalk(this.title, this.room, this.hour);
}

class Talks  {
  
  List<DataTalk> allData = [];
  //TODO: CONSTRUTOR CHAMAR METODO INIT
  
  void initState() {

    final DatabaseReference ref = FirebaseDatabase.instance.reference();

    ref.child('talks').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;

      var data = snap.value;
      allData.clear();

      for (var key in keys) {
        DataTalk auxiliar = DataTalk(
          data[key]['title'],
          data[key]['room'],
          data[key]['hour'],
        );

        allData.add(auxiliar);
        
      }
    });
  }
}
