class RmsState {
  List<dynamic> chartData;
  List<dynamic> chartData2;
  List<dynamic> list;
  String startDate;
  String endDate;
  String name;
  String currentBranchName;
  String username;
  String password;

  RmsState(
      {this.name,
      this.username,
      this.password,
      this.chartData,
      this.chartData2,
      this.startDate,
      this.endDate,
      this.list,
      this.currentBranchName});

  factory RmsState.initial() {
    return RmsState(
        currentBranchName: "All Branch",
        list: [],
        chartData: [],
        chartData2: []);
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

  factory RmsState.gotDateRange(username, password, currentBranchName, list,
      data, data2, start_date, end_date) {
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

  factory RmsState.gotOrganzationBranch(username, password, currentBranchName,
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

  factory RmsState.gotBranchName(username, password, currentBranchName, list,
      data, data2, start_date, end_date) {
    return RmsState(
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

  factory RmsState.gotLogin(username, password, list) {
    return RmsState(username: username, password: password, list: list);
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
