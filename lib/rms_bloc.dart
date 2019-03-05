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

      yield RmsState.gotData(data, currentState.startDate, currentState.endDate);
    }
    if (event is DailySales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotDailySalesData(data, currentState.startDate, currentState.endDate);
    }
    if (event is MonthlySales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotMonthlySalesData(data, currentState.startDate, currentState.endDate);
    }
    if (event is YearlySales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotYearlySalesData(data, currentState.startDate, currentState.endDate);
    }

    if (event is Top10SalesItem) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotTop10SalesItemData(data, currentState.startDate, currentState.endDate);
    }
    if (event is TodaySales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotTodaySalesData(data, currentState.startDate, currentState.endDate);
    }
    if (event is ThisMonthSales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotThisMonthSalesData(data, currentState.startDate, currentState.endDate);
    }
    if (event is ThisWeekSales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotThisWeekSalesData(data, currentState.startDate, currentState.endDate);
    }
    if (event is ThisYearSales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotThisYearSalesData(data, currentState.startDate, currentState.endDate);
    }

    if (event is DateRange) {
      var data = event.result;
      var start_date = event.start_date;
      var end_date = event.end_date;

      yield RmsState.gotDateRange(data,start_date,end_date);
    }
  }
}
