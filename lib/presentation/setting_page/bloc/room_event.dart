abstract class RoomEvent {}

class GetRoomIndexEvent extends RoomEvent {}

class UpdateRoomIndexEvent extends RoomEvent {
  final int roomIndex;

  UpdateRoomIndexEvent({required this.roomIndex});
}

class ModifyRoomIndexEvent extends RoomEvent {
  final int roomIndex;

  ModifyRoomIndexEvent({required this.roomIndex});
}
