

class RmsState {

List<dynamic> chartData;
List<dynamic> list;
String startDate;
String endDate;
String name;
String currentBranchName;


RmsState({
  this.name,
  this.chartData,
  this.startDate,
  this.endDate,
  this.list,
  this.currentBranchName
});


  factory RmsState.initial(){
    return RmsState(currentBranchName: "All Branch" ,list: [],chartData: []);
  }

factory RmsState.gotData(currentBranchName,list,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotDailySalesData(currentBranchName,list,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotMonthlySalesData(currentBranchName,list,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotYearlySalesData(currentBranchName,list,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotTop10SalesItemData(currentBranchName,list,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotTodaySalesData(currentBranchName,list,name,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisMonthSalesData(currentBranchName,list,name,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisWeekSalesData(currentBranchName,list,name,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotThisYearSalesData(currentBranchName,list,name,data , start_date, end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,name: name, chartData: data, startDate: start_date, endDate: end_date);
}

factory RmsState.gotDateRange(currentBranchName,list,data,start_date,end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data,startDate: start_date, endDate: end_date);
}

factory RmsState.gotOrganzationBranch(currentBranchName,list,data,start_date,end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data,startDate: start_date, endDate: end_date);
}

factory RmsState.gotBranchName(currentBranchName,list,data,start_date,end_date){
  return RmsState(currentBranchName: currentBranchName,list:list,chartData: data,startDate: start_date, endDate: end_date);
}






}