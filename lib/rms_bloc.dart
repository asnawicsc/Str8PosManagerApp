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

      var _chatChannel = Channel(user: currentState.username, licenseKey: currentState.password);


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

    if (event is DateRange) {

      var start_date = event.start_date;
      var end_date = event.end_date;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;



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

    if (event is MonthRange) {

      var start_month = event.start_month;
      var end_month = event.end_month;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;



      yield RmsState.gotDateRange(showTable,showGraph,
          currentState.username,
          currentState.password,
          currentState.currentBranchName,
          currentState.list,
          currentState.chartData,
          currentState.chartData2,
          start_month,
          end_month);
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
          currentState.endDate,
          currentState.startMonth,
          currentState.endMonth);
    }

    if (event is BranchName) {
      var start_date = event.start_date;
      var end_date = event.end_date;
      var start_month = event.start_month;
      var end_month = event.end_month;
      var username = currentState.username;
      var password = currentState.password;
      String currentBranchName = event.currentBranchName;
      var total_data1 = currentState.total_data1;
      var total_data2 = currentState.total_data2;


      var _chatChannel;
      _chatChannel = Channel(user: username, licenseKey: password);



if  (start_date != null) {
      _chatChannel.push("daily_sales_all", {
        "date_start": start_date,
        "date_end": end_date,
        "organization_code": _chatChannel.user,
      });

      _chatChannel.socket.disconnect();
}



      if  (start_month != null) {
        _chatChannel.push("monthly_sales_all", {
          "date_start": start_month,
          "date_end": end_month,
          "organization_code": _chatChannel.user,
        });

        _chatChannel.socket.disconnect();
      }


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
          currentState.startMonth,
          currentState.endMonth,
          currentState.username,
          currentState.password,
      );


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
          currentState.endDate,
          currentState.startMonth,
          currentState.endMonth
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

    if (event is MonthlySalesAll) {
      var total_data4 = event.total_data4;
      var total_data5 = event.total_data5;
      var total_data6 = event.total_data6;
      var showTable = currentState.showTable;
      var showGraph = currentState.showGraph;


      yield RmsState.gotMonthlySalesAll(showTable,showGraph,total_data4, total_data5,total_data6, currentState.username,
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
          currentState.endDate,
          currentState.startMonth,
          currentState.endMonth);

    }
  }
}
