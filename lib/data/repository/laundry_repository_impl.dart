import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lotura/data/data_source/laundry/local/local_laundry_data_source.dart';
import 'package:lotura/data/dto/response/laundry_response.dart';
import 'package:lotura/domain/repository/laundry_repository.dart';
import 'package:lotura/secret.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LaundryRepositoryImpl implements LaundryRepository {
  final StreamController<List<LaundryResponse>> _streamController;
  final LocalLaundryDataSource _localLaundryDataSource;

  IO.Socket socket = IO.io(
      '$baseurl/application',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .build());

  @override
  Stream<List<LaundryResponse>> get laundryList =>
      _streamController.stream.asBroadcastStream();

  LaundryRepositoryImpl(this._streamController, this._localLaundryDataSource);

  @override
  void init() {
    socket.onConnect((data) => debugPrint("연결 성공"));
    socket.on('update', (data) {
      List<LaundryResponse> laundryList = List.empty(growable: true);
      laundryList = (data as List<dynamic>)
          .map((i) => LaundryResponse.fromJson(i))
          .toList();
      _streamController.sink.add(laundryList);
    });
  }

  @override
  V getValue<V>({required String key}) =>
      _localLaundryDataSource.getValue(key: key);

  @override
  Future<void> setValue<V>({required String key, required V value}) =>
      _localLaundryDataSource.setValue(key: key, value: value);
}
