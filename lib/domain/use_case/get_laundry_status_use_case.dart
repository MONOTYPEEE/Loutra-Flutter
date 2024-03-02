import 'package:lotura/domain/entity/laundry_entity.dart';
import 'package:lotura/domain/repository/laundry_repository.dart';

class GetLaundryStatusUseCase {
  final LaundryRepository _laundryRepository;

  GetLaundryStatusUseCase({required LaundryRepository laundryRepository})
      : _laundryRepository = laundryRepository;

  Stream<LaundryEntity> get laundryList => _laundryRepository.laundryList;

  void execute() {
    _laundryRepository.webSocketInit();
  }
}
