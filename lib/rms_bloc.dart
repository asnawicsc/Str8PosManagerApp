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


      yield RmsState.gotData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
    }
    if (event is DailySales) {
      var data = event.result;


      print("data: ${data}");
      yield RmsState.gotDailySalesData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
    }
    if (event is MonthlySales) {
      var data = event.result;

      print("data: ${data}");
      yield RmsState.gotMonthlySalesData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
    }
    if (event is YearlySales) {
      var data = event.result;

      print("data: ${data}");
      yield RmsState.gotYearlySalesData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
    }

    if (event is Top10SalesItem) {
      var data = event.result;
      var list = event.list;
      print("data: ${data}");
      yield RmsState.gotTop10SalesItemData(currentState.currentBranchName,currentState.list,data, currentState.startDate, currentState.endDate);
    }
    if (event is TodaySales) {
      var data = event.result;

      var name = event.name;
      print("data: ${data}");
      yield RmsState.gotTodaySalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
    }
    if (event is ThisMonthSales) {
      var data = event.result;
      var list = event.list;
      var name = event.name;
      print("data: ${data}");
      yield RmsState.gotThisMonthSalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
    }
    if (event is ThisWeekSales) {
      var data = event.result;

      var name = event.name;
      print("data: ${data}");
      yield RmsState.gotThisWeekSalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
    }
    if (event is ThisYearSales) {
      var data = event.result;

      var name = event.name;
      print("data: ${data}");
      yield RmsState.gotThisYearSalesData(currentState.currentBranchName,currentState.list,name,data, currentState.startDate, currentState.endDate);
    }

    if (event is DateRange) {
      var data = event.result;

      var start_date = event.start_date;
      var end_date = event.end_date;

      yield RmsState.gotDateRange(currentState.currentBranchName,currentState.list,data,start_date,end_date);
    }

    if (event is OrganzationBranch) {
      var list = event.list;


      yield RmsState.gotOrganzationBranch(currentState.currentBranchName,list,currentState.chartData, currentState.startDate, currentState.endDate);
    }

    if (event is BranchName) {
      var currentBranchName = event.currentBranchName;


      yield RmsState.gotBranchName(currentBranchName,currentState.list,currentState.chartData, currentState.startDate, currentState.endDate);
    }
  }
}
