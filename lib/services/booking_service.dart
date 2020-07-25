import 'package:mypetcare_userprofile/services/data_service.dart';
import 'package:mypetcare_userprofile/models/bookingList.dart';

class BookingDataService {
  static final BookingDataService _instance = BookingDataService._constructor();
  factory BookingDataService() {
    return _instance;
  }

  BookingDataService._constructor();
  final rest = RestService();

  Future<List<ClinicList>> getClinicList() async {
    final listJson = await rest.get('clinicList');

    return (listJson as List)
        .map((itemJson) => ClinicList.fromJson(itemJson))
        .toList();
  }

  Future<ClinicList> updateBooking({String clinicId, List<BookingList> bookingList}) async {
    final json = await rest.patch('clinicList/$clinicId', data: {'bookingList': bookingList});
    return ClinicList.fromJson(json);
  }  
}