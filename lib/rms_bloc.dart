import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'rms.dart';
import 'channel/channel.dart';

class RmsBloc extends Bloc<RmsEvent, RmsState> {
  Channel channel;
  RmsState get initialState => RmsState.initial();

  @override
  Stream<RmsState> mapEventToState(
    RmsState currentState,
    RmsEvent event,
  ) async* {
    if (event is ReadData) {
      var data = event.result;
      var data2 = event.result2;

      yield RmsState.gotData(
          currentState.username,
          currentState.password,
          currentState.currentBranchName,
          currentState.list,
          data,
          data2,
          currentState.startDate,
          currentState.endDate);
    }
    if (event is DailySales) {
      var data = event.result;
      var data2 = event.result2;
      var rmsBloc;

      var _chatChannel;
      _chatChannel = Channel(user: currentState.username, licenseKey: currentState.password);


//
//
//      print("rere: ${event.result}");
      yield RmsState.gotDailySalesData(
          currentState.currentBranchName,
          currentState.list,
          currentState.username,
          currentState.password,
          data,
          data2,
          currentState.startDate,
          currentState.endDate);
    }
//    if (event is MonthlySales) {
//      var data = event.result;
//
//
//      yield RmsState.gotMonthlySalesData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
//    }
//    if (event is YearlySales) {
//      var data = event.result;
//
//
//      yield RmsState.gotYearlySalesData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
//    }
//
//    if (event is Top10SalesItem) {
//      var data = event.result;
//      var list = event.list;
//
//      yield RmsState.gotTop10SalesItemData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
//    }
//    if (event is TodaySales) {
//      var data = event.result;
//
//      var name = event.name;
//
//      yield RmsState.gotTodaySalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
//    }
//    if (event is ThisMonthSales) {
//      var data = event.result;
//      var list = event.list;
//      var name = event.name;
//
//      yield RmsState.gotThisMonthSalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
//    }
//    if (event is ThisWeekSales) {
//      var data = event.result;
//
//      var name = event.name;
//
//      yield RmsState.gotThisWeekSalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
//    }
//    if (event is ThisYearSales) {
//      var data = event.result;
//
//      var name = event.name;
//
//      yield RmsState.gotThisYearSalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
//    }

    if (event is DateRange) {

      var start_date = event.start_date;
      var end_date = event.end_date;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;

//      var _chatChannel;
//      _chatChannel = Channel(user: currentState.username, licenseKey: currentState.password);
////
//      _chatChannel
//          .push("organization_branch", {"organization_code": "resertech"});
//      print("eventcurent2: ${event.currentBranchName}");

//      print("dsadsssad: ${currentBranchName}");
//      _chatChannel.push("daily_sales", {
//        "date_start": start_date,
//        "date_end": end_date,
//        "organization_code": "resertech",
//        "branch_name": currentBranchName
//      });


      yield RmsState.gotDateRange(showTable,showGraph,
          currentState.username,
          currentState.password,
          currentState.currentBranchName,
          currentState.list,
          currentState.chartData,
          currentState.chartData2,
          start_date,
          end_date);
    }

    if (event is OrganzationBranch) {
      var list = event.list;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;

      yield RmsState.gotOrganzationBranch(showTable,showGraph,
          currentState.username,
          currentState.password,
          currentState.currentBranchName,
          list,
          currentState.chartData,
          currentState.chartData2,
          currentState.startDate,
          currentState.endDate);
    }

    if (event is BranchName) {
      var start_date = event.start_date;
      var end_date = event.end_date;
      var username = currentState.username;
      var password = currentState.password;
      String currentBranchName = event.currentBranchName;
      var total_data1 = currentState.total_data1;
      var total_data2 = currentState.total_data2;


//
//
      var _chatChannel;
      _chatChannel = Channel(user: username, licenseKey: password);
//
//      _chatChannel.push("daily_sales", {
//        "date_start": start_date,
//        "date_end": end_date,
//        "organization_code": _chatChannel.user,
//        "branch_name": currentBranchName
//      });


      _chatChannel.push("daily_sales_all", {
        "date_start": start_date,
        "date_end": end_date,
        "organization_code": _chatChannel.user,
      });


      var data = currentState.chartData;
      var data2 = currentState.chartData2;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;


      yield RmsState.gotBranchName(showTable,showGraph,total_data1, total_data2,
          currentBranchName,
          currentState.list,
          data,
          data2,
          currentState.startDate,
          currentState.endDate,
          currentState.username,
          currentState.password);


    }

    if (event is Login) {
      var username = event.username;
      var password = event.password;
      var list = event.list;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;

      yield RmsState.gotLogin(showTable,showGraph,username, password, list, currentState.currentBranchName, currentState.chartData,
          currentState.chartData2,
          currentState.startDate,
          currentState.endDate
       );
    }

    if (event is DailySalesAll) {
      var total_data1 = event.total_data1;
      var total_data2 = event.total_data2;
      var total_data3 = event.total_data3;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;


      yield RmsState.gotDailySalesAll(showTable,showGraph,total_data1, total_data2,total_data3, currentState.username,
          currentState.password,
          currentState.currentBranchName,
          currentState.list,
          currentState.chartData,
          currentState.chartData2,
          currentState.startDate,
          currentState.endDate);

    }

    if (event is Setting) {
      var showTable = event.showTable;
      var showGraph = event.showGraph;
      var total_data1 = currentState.total_data1;
      var total_data2 = currentState.total_data2;


      yield RmsState.gotSetting(showTable, showGraph,total_data1,total_data2, currentState.username,
          currentState.password,
          currentState.currentBranchName,
          currentState.list,
          currentState.chartData,
          currentState.chartData2,
          currentState.startDate,
          currentState.endDate);

    }
  }
}
