

class RmsState {

List<dynamic> chartData;
String startDate;
String endDate;
String name;


RmsState({
  this.name,
  this.chartData,
  this.startDate,
  this.endDate
});


  factory RmsState.initial(){
    return RmsState(chartData: []);
  }

factory RmsState.gotData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotDailySalesData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotMonthlySalesData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotYearlySalesData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotTop10SalesItemData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotTodaySalesData(name,data , start_date, end_date){
  return RmsState(name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisMonthSalesData(name,data , start_date, end_date){
  return RmsState(name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisWeekSalesData(name,data , start_date, end_date){
  return RmsState(name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisYearSalesData(name,data , start_date, end_date){
  return RmsState(name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotDateRange(data,start_date,end_date){
  return RmsState(chartData: data,startDate: start_date, endDate: end_date);
}





}