import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lotura/data/dto/request/apply_cancel_request.dart';
import 'package:lotura/data/dto/request/send_fcm_info_request.dart';
import 'package:lotura/main.dart';
import 'package:lotura/presentation/apply_page/bloc/apply_bloc.dart';
import 'package:lotura/presentation/apply_page/bloc/apply_event.dart';
import 'package:lotura/presentation/setting_page/bloc/room_bloc.dart';
import 'package:lotura/presentation/setting_page/bloc/room_event.dart';
import 'package:lotura/presentation/utils/lotura_colors.dart';
import 'package:lotura/presentation/utils/osj_text_button.dart';

class OSJBottomSheet extends StatefulWidget {
  const OSJBottomSheet({
    super.key,
    required this.index,
    required this.isEnableNotification,
    required this.isWoman,
    required this.state,
    required this.machine,
  });

  final int index;
  final bool isEnableNotification, isWoman;
  final CurrentState state;
  final Machine machine;

  @override
  State<OSJBottomSheet> createState() => _OSJBottomSheetState();
}

class _OSJBottomSheetState extends State<OSJBottomSheet> {
  String text(bool isEnableNotification, isWoman, CurrentState state) {
    if (isEnableNotification) {
      if (isWoman) {
        switch (state) {
          case CurrentState.working:
            return "여자 세탁실 ${widget.index - 31}번 ${widget.machine.text}의\n완료 알림을 설정할까요?";
          case CurrentState.available:
            return "여자 세탁실 ${widget.index - 31}번 ${widget.machine.text}는\n사용할 수 있어요.";
          case CurrentState.disconnected:
            return "여자층 ${widget.index - 31}번 ${widget.machine.text}의 연결이 끊겨서\n상태를 확인할 수 없어요.";
          case CurrentState.breakdown:
            return "여자 세탁실 ${widget.index - 31}번 ${widget.machine.text}는\n고장으로 인해 사용할 수 없어요.";
        }
      } else {
        switch (state) {
          case CurrentState.working:
            return "${widget.index}번 ${widget.machine.text}의\n완료 알림을 설정할까요?";
          case CurrentState.available:
            return "${widget.index}번 ${widget.machine.text}는\n사용할 수 있어요.";
          case CurrentState.disconnected:
            return "${widget.index}번 ${widget.machine.text}의 연결이 끊겨서\n상태를 확인할 수 없어요.";
          case CurrentState.breakdown:
            return "${widget.index}번 ${widget.machine.text}는\n고장으로 인해 사용할 수 없어요.";
        }
      }
    } else {
      if (isWoman) {
        return "여자 세탁실 ${widget.index - 31}번 ${widget.machine.text}의\n완료 알림을 해제할까요?";
      } else {
        return "${widget.index}번 ${widget.machine.text}의\n완료 알림을 해제할까요?";
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(ShowingBottomSheetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) async {
        context.read<RoomBloc>().add(ClosingBottomSheetEvent());
        return Future(() => true);
      },
      child: SizedBox(
        width: double.infinity,
        height: widget.state == CurrentState.working ? 220.0.h : 268.0.h,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.0.w,
            right: 24.0.w,
            top: 32.0.h,
            bottom: 12.0.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.state == CurrentState.working
                  ? const SizedBox.shrink()
                  : Icon(
                      widget.state.icon,
                      size: 24.0.r,
                      color: widget.state == CurrentState.available
                          ? LoturaColors.green700
                          : widget.state == CurrentState.disconnected
                              ? LoturaColors.black
                              : LoturaColors.red700,
                    ),
              Padding(
                padding: widget.state == CurrentState.working
                    ? EdgeInsets.only(bottom: 24.0.h)
                    : EdgeInsets.only(top: 24.0.h, bottom: 24.0.h),
                child: Text(
                  text(widget.isEnableNotification, widget.isWoman,
                      widget.state),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              widget.state == CurrentState.working
                  ? Row(
                      children: [
                        OSJTextButton(
                            function: () {
                              Navigator.of(context).pop();
                              context
                                  .read<RoomBloc>()
                                  .add(ClosingBottomSheetEvent());
                            },
                            width: 185.0.w,
                            height: 56.0.h,
                            fontSize: 16.0.sp,
                            color: LoturaColors.gray100,
                            fontColor: LoturaColors.black,
                            text: "취소"),
                        SizedBox(width: 12.0.w),
                        OSJTextButton(
                            function: () {
                              widget.isEnableNotification
                                  ? context.read<ApplyBloc>().add(SendFCMEvent(
                                      sendFCMInfoRequest: SendFCMInfoRequest(
                                          deviceId: widget.index.toString(),
                                          expectState: '1')))
                                  : context.read<ApplyBloc>().add(
                                      ApplyCancelEvent(
                                          applyCancelRequest:
                                              ApplyCancelRequest(
                                                  deviceId: widget.index
                                                      .toString())));
                              context
                                  .read<RoomBloc>()
                                  .add(ClosingBottomSheetEvent());
                              Navigator.pop(context);
                            },
                            width: 185.0.w,
                            height: 56.0.h,
                            fontSize: 16.0.sp,
                            color: LoturaColors.primary700,
                            fontColor: LoturaColors.white,
                            text: widget.isEnableNotification
                                ? "알림 설정"
                                : "알림 해제"),
                      ],
                    )
                  : Center(
                      child: OSJTextButton(
                          function: () {
                            context
                                .read<RoomBloc>()
                                .add(ClosingBottomSheetEvent());
                            Navigator.of(context).pop();
                          },
                          width: 382.0.w,
                          height: 56.0.h,
                          fontSize: 16.0.sp,
                          color: LoturaColors.gray100,
                          fontColor: LoturaColors.black,
                          text: "확인"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
