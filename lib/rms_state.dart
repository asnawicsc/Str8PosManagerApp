

class RmsState {

List<dynamic> chartData;
String startDate;
String endDate;


RmsState({
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

factory RmsState.gotTodaySalesData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisMonthSalesData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisWeekSalesData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisYearSalesData(data , start_date, end_date){
  return RmsState(chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotDateRange(data,start_date,end_date){
  return RmsState(chartData: data,startDate: start_date, endDate: end_date);
}





}