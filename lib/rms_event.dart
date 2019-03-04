
abstract class RmsEvent {}
class ReadData extends RmsEvent {
List<dynamic> result;
ReadData({this.result});

}

class DailySales extends RmsEvent {
  List<dynamic> result;


  DailySales({this.result});

}

class MonthlySales extends RmsEvent {
  List<dynamic> result;


  MonthlySales({this.result});

}

class YearlySales extends RmsEvent {
  List<dynamic> result;


  YearlySales({this.result});

}

class Top10SalesItem extends RmsEvent {
  List<dynamic> result;


  Top10SalesItem({this.result});

}

class TodaySales extends RmsEvent {
  List<dynamic> result;


  TodaySales({this.result});

}