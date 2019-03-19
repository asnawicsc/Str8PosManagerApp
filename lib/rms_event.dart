
abstract class RmsEvent {}
class ReadData extends RmsEvent {
List<dynamic> result;
List<dynamic> result2;
List<dynamic> list;
String name;
ReadData({this.list,this.result,this.result2, this.name});

}

class DailySales extends RmsEvent {
  List<dynamic> result;
  List<dynamic> result2;
  List<String> list;

  DailySales({this.list,this.result,this.result2});

}

class MonthlySales extends RmsEvent {
  List<dynamic> result;
  List<String> list;


  MonthlySales({this.list,this.result});

}

class YearlySales extends RmsEvent {
  List<dynamic> result;
  List<String> list;

  YearlySales({this.list,this.result});

}

class Top10SalesItem extends RmsEvent {
  List<dynamic> result;
  List<String> list;

  Top10SalesItem({this.list,this.result});

}

class TodaySales extends RmsEvent {
  String name;
  List<dynamic> result;
  List<String> list;

  TodaySales({this.list,this.name,this.result});

}

class ThisMonthSales extends RmsEvent {
  String name;
  List<dynamic> result;
  List<String> list;

  ThisMonthSales({this.list,this.name,this.result});

}

class ThisWeekSales extends RmsEvent {
  List<dynamic> result;
  String name;
  List<String> list;

  ThisWeekSales({this.list,this.name,this.result});

}
class ThisYearSales extends RmsEvent {
  String name;
  List<dynamic> result;
  List<String> list;

  ThisYearSales({this.list,this.name,this.result});

}

class DateRange extends RmsEvent {
  List<dynamic> result;
  String start_date;
  String end_date;
  List<String> list;

  DateRange({this.list,this.result,this.start_date,this.end_date});

}

class OrganzationBranch extends RmsEvent {
  String currentBranchName;
  List<dynamic> result;
  String start_date;
  String end_date;
  List<String> list;
  OrganzationBranch({this.list});

}

class BranchName extends RmsEvent {
  String currentBranchName;
  List<dynamic> result;
  String start_date;
  String end_date;
  List<String> list;
  BranchName({this.currentBranchName});

}