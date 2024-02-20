import 'package:lotura/domain/entity/apply_entity.dart';

class ApplyResponse {
  final int deviceId;
  final String deviceType;

  ApplyResponse({required this.deviceId, required this.deviceType});

  factory ApplyResponse.fromJson(Map<String, dynamic> json) {
    return ApplyResponse(
      deviceId: json['device_id'],
      deviceType: json['device_type'],
    );
  }

  ApplyEntity toEntity() =>
      ApplyEntity(deviceId: deviceId, deviceType: deviceType);
}
