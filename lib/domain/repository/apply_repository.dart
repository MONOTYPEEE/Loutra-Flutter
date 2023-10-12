import 'dart:async';
import 'package:lotura/data/dto/request/apply_cancel_request.dart';
import 'package:lotura/data/dto/request/get_apply_list_request.dart';
import 'package:lotura/data/dto/request/send_fcm_info_request.dart';
import 'package:lotura/data/dto/response/apply_response.dart';

abstract class ApplyRepository {
  Stream<List<ApplyResponse>> get applyStream;

  void getApplyList(GetApplyListRequest getApplyListRequest);

  void response();

  void sendFCMInfo(SendFCMInfoRequest sendFCMInfoRequest);

  void applyCancel(ApplyCancelRequest applyCancelRequest);
}