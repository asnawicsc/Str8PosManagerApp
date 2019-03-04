
abstract class RmsEvent {}
class ReadData extends RmsEvent {
List<dynamic> result;
ReadData({this.result});

}

class DailySales extends RmsEvent {
  List<dynamic> result;


  DailySales({this.result});

}