
abstract class RmsEvent {}
class ReadData extends RmsEvent {
List<dynamic> result;
List<dynamic> result2;
List<dynamic> list;
String name;
String username;
String password;
String currentBranchName;
String start_date;
String end_date;
ReadData({this.username,this.password,this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date});

}

class DailySales extends RmsEvent {
  List<dynamic> result;
  List<dynamic> result2;
  List<dynamic> list;
  String start_date;
  String end_date;
  String username;
  String password;
  String currentBranchName;
  DailySales({this.username,this.password,this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date});

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
  List<dynamic> result2;
  String start_date;
  String end_date;
  List<String> list;
  String username;
  String password;
  String currentBranchName;

  DateRange({this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date,this.username,this.password});

}

class OrganzationBranch extends RmsEvent {
  String currentBranchName;
  List<dynamic> result;
  List<dynamic> result2;
  String start_date;
  String end_date;
  String username;
  String password;
  List<String> list;
  OrganzationBranch({this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date,this.username,this.password});

}

class BranchName extends RmsEvent {
  String currentBranchName;
  List<dynamic> result;
  List<dynamic> result2;
  List<dynamic> total_data1;
  List<dynamic> total_data2;
  String start_date;
  String end_date;
  List<String> list;
  String username;
  String password;
  BranchName({this.total_data1,this.total_data2,this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date,this.username,this.password});

}

class Login extends RmsEvent {
  String currentBranchName;
  List<dynamic> result;
  List<dynamic> result2;
  String start_date;
  String end_date;
  String username;
  String password;
  List<String> list;
  Login({this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date,this.username,this.password});

}

class DailySalesAll extends RmsEvent {
  List<dynamic> total_data1;
  List<dynamic> total_data2;
  List<dynamic> total_data3;
  String currentBranchName;
  List<dynamic> result;
  List<dynamic> result2;
  String start_date;
  String end_date;
  List<String> list;
  String username;
  String password;

  DailySalesAll({this.total_data1,this.total_data2,this.total_data3,this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date,this.username,this.password});

}

class Setting extends RmsEvent {
  bool showTable;
  bool showGraph;
  List<dynamic> total_data1;
  List<dynamic> total_data2;
  String currentBranchName;
  List<dynamic> result;
  List<dynamic> result2;
  String start_date;
  String end_date;
  List<String> list;
  String username;
  String password;

  Setting({this.showGraph,this.showTable,this.total_data1,this.total_data2,this.currentBranchName,this.list,this.result,this.result2,this.start_date,this.end_date,this.username,this.password});

}