class BookingDetail {
  String name,email,phone,reason,date,time;  

  BookingDetail(this.name,this.email,this.phone,this.reason,this.date,this.time);
  BookingDetail.copy(BookingDetail from): this(from.name,from.email,from.phone,from.reason,from.date,from.time);
}

class BookingList {  
  String name;
  double rate;
  String address;
  BookingDetail bookingDetail;

  BookingList(this.name,this.rate,this.address,this.bookingDetail);
  BookingList.copy(BookingList from): this(from.name,from.rate,from.address,from.bookingDetail);
}