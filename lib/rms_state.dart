

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

factory RmsState.gotData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotDailySalesData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotMonthlySalesData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotYearlySalesData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotTop10SalesItemData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotTodaySalesData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotThisMonthSalesData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotThisWeekSalesData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotThisYearSalesData(data){
  return RmsState(chartData: data);
}

factory RmsState.gotDateRange(start_date,end_date){
  return RmsState(startDate: start_date, endDate: end_date);
}





}