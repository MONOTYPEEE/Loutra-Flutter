import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lotura/domain/entity/room_entity.dart';
import 'package:lotura/domain/use_case/get_laundry_room_index_use_case.dart';
import 'package:lotura/domain/use_case/update_laundry_room_index_use_case.dart';
import 'package:lotura/main.dart';
import 'package:lotura/presentation/setting_page/bloc/room_event.dart';
import 'package:lotura/presentation/setting_page/bloc/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState<RoomEntity>> {
  final GetLaundryRoomIndexUseCase _getLaundryRoomIndexUseCase;
  final UpdateLaundryRoomIndexUseCase _updateLaundryRoomIndexUseCase;

  RoomBloc(
      {required GetLaundryRoomIndexUseCase getLaundryRoomIndexUseCase,
      required UpdateLaundryRoomIndexUseCase updateLaundryRoomIndexUseCase})
      : _getLaundryRoomIndexUseCase = getLaundryRoomIndexUseCase,
        _updateLaundryRoomIndexUseCase = updateLaundryRoomIndexUseCase,
        super(Initial(
            data: const RoomEntity(
                roomLocation: RoomLocation.schoolSide,
                buttonView: ButtonView.icon,
                isClick: false,
                isNFCShowBottomSheet: false))) {
    on<UpdateRoomIndexEvent>(_updateRoomIndexEventHandler);
    on<GetRoomIndexEvent>(_getRoomIndexEventHandler);
    on<ModifyRoomIndexEvent>(_modifyRoomIndexEventHandler);
    on<ModifyPlaceIconIndexEvent>(_modifyPlaceIconIndexEventHandler);
    on<ShowBottomSheetEvent>(_showBottomSheetEventHandler);
    on<InitialShowBottomSheetEvent>(_initialShowBottomSheetEventHandler);
  }

  void _updateRoomIndexEventHandler(
      UpdateRoomIndexEvent event, Emitter<RoomState<RoomEntity>> emit) {
    emit(Changed(data: state.value.copyWith(roomLocation: event.roomLocation)));
    _updateLaundryRoomIndexUseCase.execute(value: event.roomLocation.index);
  }

  void _getRoomIndexEventHandler(
      GetRoomIndexEvent event, Emitter<RoomState<RoomEntity>> emit) {
    emit(Changed(
        data: state.value.copyWith(
            roomLocation: RoomLocation.values
                .elementAt(_getLaundryRoomIndexUseCase.execute))));
  }

  void _modifyRoomIndexEventHandler(
      ModifyRoomIndexEvent event, Emitter<RoomState<RoomEntity>> emit) {
    emit(Changed(data: state.value.copyWith(roomLocation: event.roomLocation)));
  }

  void _modifyPlaceIconIndexEventHandler(
      ModifyPlaceIconIndexEvent event, Emitter<RoomState<RoomEntity>> emit) {
    emit(Changed(data: state.value.copyWith(buttonView: event.buttonView)));
  }

  void _showBottomSheetEventHandler(
      ShowBottomSheetEvent event, Emitter<RoomState<RoomEntity>> emit) {
    emit(Changed(data: state.value.copyWith(isNFCShowBottomSheet: true)));
  }

  void _initialShowBottomSheetEventHandler(
      InitialShowBottomSheetEvent event, Emitter<RoomState<RoomEntity>> emit) {
    emit(Changed(data: state.value.copyWith(isNFCShowBottomSheet: false)));
  }
}
