

class RmsState {

List<dynamic> chartData;


RmsState({
  this.chartData
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





}