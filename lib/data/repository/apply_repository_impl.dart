import 'dart:async';

import 'package:lotura/data/data_source/apply/remote/remote_apply_data_source.dart';
import 'package:lotura/data/dto/request/apply_cancel_request.dart';
import 'package:lotura/data/dto/request/send_fcm_info_request.dart';
import 'package:lotura/data/dto/response/apply_response.dart';
import 'package:lotura/domain/repository/apply_repository.dart';

class ApplyRepositoryImpl implements ApplyRepository {
  final RemoteApplyDataSource _remoteApplyDataSource;

  ApplyRepositoryImpl({required RemoteApplyDataSource remoteApplyDataSource})
      : _remoteApplyDataSource = remoteApplyDataSource;

  @override
  Stream<List<ApplyResponse>> get applyStream =>
      _remoteApplyDataSource.applyStream.asBroadcastStream();

  @override
  Future<List<ApplyResponse>> getApplyList() async =>
      _remoteApplyDataSource.getApplyList();

  @override
  void response() => _remoteApplyDataSource.response();

  @override
  void sendFCMInfo(SendFCMInfoRequest sendFCMInfoRequest) =>
      _remoteApplyDataSource.sendFCMInfo(sendFCMInfoRequest);

  @override
  void applyCancel(ApplyCancelRequest applyCancelRequest) =>
      _remoteApplyDataSource.applyCancel(applyCancelRequest);
}
