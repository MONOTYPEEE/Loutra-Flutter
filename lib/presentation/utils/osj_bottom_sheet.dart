import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lotura/data/dto/request/apply_cancel_request.dart';
import 'package:lotura/data/dto/request/send_fcm_info_request.dart';
import 'package:lotura/main.dart';
import 'package:lotura/presentation/main_page/bloc/apply_bloc.dart';
import 'package:lotura/presentation/main_page/bloc/apply_event.dart';
import 'package:lotura/presentation/utils/osj_colors.dart';
import 'package:lotura/presentation/utils/osj_icons.dart';
import 'package:lotura/presentation/utils/osj_text_button.dart';

class OSJBottomSheet extends StatelessWidget {
  OSJBottomSheet({
    super.key,
    required this.index,
    required this.isEnableNotification,
    required this.isWoman,
    required this.status,
    required this.machine,
  });

  final int index;
  final bool isEnableNotification, isWoman;
  final Status status;
  final Machine machine;

  final Map statusColor = <Status, Color>{
    Status.available: OSJColors.green50,
    Status.working: OSJColors.primary50,
    Status.disconnected: OSJColors.black,
    Status.breakdown: OSJColors.red50,
  };

  final Map statusIcon = <Status, IconData>{
    Status.available: OSJIcons.checkCircle,
    Status.working: OSJIcons.working,

    /// 아이콘 바꿔야됨
    Status.disconnected: Icons.not_interested,
    Status.breakdown: OSJIcons.breakdown,
  };

  final Map machineIcon = <Machine, IconData>{
    Machine.wash: OSJIcons.laundry,
    Machine.dry: OSJIcons.dry,
  };

  final Map machineText = <Machine, String>{
    Machine.wash: "세탁기",
    Machine.dry: "건조기",
  };

  String text(bool isEnableNotification, isWoman, Status status) {
    if (isEnableNotification) {
      if (isWoman) {
        switch (status) {
          case Status.working:
            return "여자 세탁실 ${index - 31}번 ${machineText[machine]}를\n알림 설정 하실건가요?";
          case Status.available:
            return "여자 세탁실 ${index - 31}번 ${machineText[machine]}는\n현재 사용 가능한 상태에요.";
          case Status.disconnected:
            return "여자 세탁실 ${index - 31}번 ${machineText[machine]}의 장치 연결이 끊겨서\n상태를 확인할 수 없어요";
          case Status.breakdown:
            return "여자 세탁실 ${index - 31}번 ${machineText[machine]}는\n고장으로 인해 사용이 불가능해요.";
        }
      } else {
        switch (status) {
          case Status.working:
            return "$index번 ${machineText[machine]}를\n알림 설정 하실건가요?";
          case Status.available:
            return "$index번 ${machineText[machine]}는\n현재 사용 가능한 상태에요.";
          case Status.disconnected:
            return "$index번 ${machineText[machine]}의 장치 연결이 끊겨서\n상태를 확인할 수 없어요";
          case Status.breakdown:
            return "$index번 ${machineText[machine]}는\n고장으로 인해 사용이 불가능해요.";
        }
      }
    } else {
      if (isWoman) {
        return "여자 세탁실 ${index - 31}번 ${machineText[machine]}의\n알림 설정을 해제하실건가요?";
      } else {
        return "$index번 ${machineText[machine]}의\n알림 설정을 해제하실건가요?";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: status == Status.working ? 220.0.h : 268.0.h,
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
            status == Status.working
                ? const SizedBox.shrink()
                : Icon(
                    statusIcon[status],
                    size: 24.0.r,
                    color: status == Status.available
                        ? OSJColors.green700
                        : status == Status.disconnected
                            ? OSJColors.black
                            : OSJColors.red700,
                  ),
            Padding(
              padding: status == Status.working
                  ? EdgeInsets.only(bottom: 24.0.h)
                  : EdgeInsets.only(top: 24.0.h, bottom: 24.0.h),
              child: Text(
                text(isEnableNotification, isWoman, status),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            status == Status.working
                ? Row(
                    children: [
                      OSJTextButton(
                          function: () => Navigator.of(context).pop(),
                          width: 185.0.w,
                          height: 56.0.h,
                          fontSize: 16.0.sp,
                          color: OSJColors.gray100,
                          fontColor: OSJColors.black,
                          text: "취소"),
                      SizedBox(width: 12.0.w),
                      OSJTextButton(
                          function: () {
                            isEnableNotification
                                ? context.read<ApplyBloc>().add(SendFCMEvent(
                                    sendFCMInfoRequest: SendFCMInfoRequest(
                                        deviceId: index, expectState: '1')))
                                : context.read<ApplyBloc>().add(
                                    ApplyCancelEvent(
                                        applyCancelRequest: ApplyCancelRequest(
                                            deviceId: index)));
                            Navigator.pop(context);
                          },
                          width: 185.0.w,
                          height: 56.0.h,
                          fontSize: 16.0.sp,
                          color: OSJColors.primary700,
                          fontColor: OSJColors.white,
                          text: isEnableNotification ? "알림 설정" : "알림 해제"),
                    ],
                  )
                : Center(
                    child: OSJTextButton(
                        function: () => Navigator.of(context).pop(),
                        width: 382.0.w,
                        height: 56.0.h,
                        fontSize: 16.0.sp,
                        color: OSJColors.gray100,
                        fontColor: OSJColors.black,
                        text: "확인"),
                  ),
          ],
        ),
      ),
    );
  }
}
