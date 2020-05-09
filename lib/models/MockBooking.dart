import 'bookingList.dart';

BookingDetail mockBookingDetail1 = BookingDetail("John","john@gmail.com","0123456789","Flu","30/1/2020","14:00");
BookingDetail mockBookingDetail2 = BookingDetail(null,null,null,null,null,null);
BookingDetail mockBookingDetail3 = BookingDetail("Mary","mary@gmail.com","0193157325","Fever","4/2/2020","19:00");

List<BookingList> mockBookingList = [
  BookingList("University Veterinary Clinic",2.9,"28, Jalan kebudayaan 18",mockBookingDetail1),
  BookingList("Batu Animal Clinic & Surgery",4.6,"No. 16, Jalan Shahbandar 6, Taman Ungku Tun Aminah, Skudai, Johor Bahru",mockBookingDetail2),
  BookingList("JB Animal Medical Clinic",4.2,"47, Jalan Putra 1",mockBookingDetail3)  
];