class RmsState {
  List<dynamic> chartData;
  List<dynamic> chartData2;
  List<dynamic> total_data1;
  List<dynamic> total_data2;
  List<dynamic> total_data3;
  List<dynamic> list;
  String startDate;
  String endDate;
  String name;
  String currentBranchName;
  String username;
  String password;
  bool showTable;
  bool showGraph;

  RmsState(
      {this.name,
      this.username,
      this.password,
      this.chartData,
      this.chartData2,
      this.startDate,
      this.endDate,
      this.list,
      this.currentBranchName,
        this.total_data1,
        this.total_data2,
        this.total_data3,
      this.showTable,
      this.showGraph});

  factory RmsState.initial() {


    return RmsState(
      currentBranchName: "All Branch",
      list: [],
      chartData: [],
      chartData2: [],
        total_data1: [],
        total_data2: [],
      showGraph: true,
      showTable: true
    );
  }

  factory RmsState.gotData(username, password, currentBranchName, list, data,
      data2, start_date, end_date) {
    return RmsState(
        username: username,
        password: password,
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        chartData2: data2,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotDailySalesData(username, password, currentBranchName,
      list, data, data2, start_date, end_date) {
    return RmsState(
        username: username,
        password: password,
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        chartData2: data2,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotDateRange(showTable, showGraph,username, password, currentBranchName, list,
      data, data2, start_date, end_date) {
    return RmsState(
        showTable: showTable,
        showGraph: showGraph,
        username: username,
        password: password,
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        chartData2: data2,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotOrganzationBranch(showTable, showGraph,username, password, currentBranchName,
      list, data, data2, start_date, end_date) {
    return RmsState(
        showTable: showTable,
        showGraph: showGraph,
        username: username,
        password: password,
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        chartData2: data2,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotBranchName(showTable, showGraph,total_data1, total_data2,username, password, currentBranchName, list,
      data, data2, start_date, end_date) {
    return RmsState(
      showTable: showTable,
      showGraph: showGraph,
      total_data1: total_data1,
      total_data2: total_data2,
      username: username,
      password: password,
      currentBranchName: currentBranchName,
      list: list,
      chartData: data,
      chartData2: data2,
      startDate: start_date,
      endDate: end_date,
    );
  }

  factory RmsState.gotLogin(showTable, showGraph,username, password, list, currentBranchName, data,
      data2, start_date, end_date) {
    return RmsState(
        showTable: showTable,
        showGraph: showGraph,
        username: username,
        password: password,
        list: list,
        currentBranchName: currentBranchName,
        chartData: data,
        chartData2: data2,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotDailySalesAll(showTable, showGraph,total_data1, total_data2,total_data3,username, password, currentBranchName, list,
      data, data2, start_date, end_date) {
    return RmsState(
        showTable: showTable,
        showGraph: showGraph,
        total_data1: total_data1,
        total_data2: total_data2,
        total_data3: total_data3,
      username: username,
      password: password,
      currentBranchName: currentBranchName,
      list: list,
      chartData: data,
      chartData2: data2,
      startDate: start_date,
      endDate: end_date
     );
  }

  factory RmsState.gotSetting(showTable, showGraph,total_data1, total_data2,username, password, currentBranchName, list,
      data, data2, start_date, end_date) {
    return RmsState(
        showTable: showTable,
        showGraph: showGraph,
        total_data1: total_data1,
        total_data2: total_data2,
        username: username,
        password: password,
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        chartData2: data2,
        startDate: start_date,
        endDate: end_date
    );
  }

  factory RmsState.gotMonthlySalesData(
      currentBranchName, list, data, start_date, end_date) {
    return RmsState(
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotYearlySalesData(
      currentBranchName, list, data, start_date, end_date) {
    return RmsState(
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotTop10SalesItemData(
      currentBranchName, list, data, start_date, end_date) {
    return RmsState(
        currentBranchName: currentBranchName,
        list: list,
        chartData: data,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotTodaySalesData(
      currentBranchName, list, name, data, start_date, end_date) {
    return RmsState(
        currentBranchName: currentBranchName,
        list: list,
        name: name,
        chartData: data,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotThisMonthSalesData(
      currentBranchName, list, name, data, start_date, end_date) {
    return RmsState(
        currentBranchName: currentBranchName,
        list: list,
        name: name,
        chartData: data,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotThisWeekSalesData(
      currentBranchName, list, name, data, start_date, end_date) {
    return RmsState(
        currentBranchName: currentBranchName,
        list: list,
        name: name,
        chartData: data,
        startDate: start_date,
        endDate: end_date);
  }

  factory RmsState.gotThisYearSalesData(
      currentBranchName, list, name, data, start_date, end_date) {
    return RmsState(
        currentBranchName: currentBranchName,
        list: list,
        name: name,
        chartData: data,
        startDate: start_date,
        endDate: end_date);
  }
}
