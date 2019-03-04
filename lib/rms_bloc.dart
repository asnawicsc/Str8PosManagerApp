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

      yield RmsState.gotData(data);
    }
    if (event is DailySales) {
      var data = event.result;
      print("data: ${data}");
      yield RmsState.gotDailySalesData(data);
    }
  }
}
