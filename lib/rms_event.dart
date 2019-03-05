
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

class ThisMonthSales extends RmsEvent {
  List<dynamic> result;


  ThisMonthSales({this.result});

}

class ThisWeekSales extends RmsEvent {
  List<dynamic> result;


  ThisWeekSales({this.result});

}
class ThisYearSales extends RmsEvent {
  List<dynamic> result;


  ThisYearSales({this.result});

}

class DateRange extends RmsEvent {
  List<dynamic> result;
  String start_date;
  String end_date;


  DateRange({this.result,this.start_date,this.end_date});

}