class BookingList {  
  String id,reason,date,time;    

  BookingList(this.id,this.reason,this.date,this.time);
  BookingList.copy(BookingList from): this(from.id,from.reason,from.date,from.time);

  BookingList.fromJson(Map<String, dynamic> json)
      : this(
            json['id'],json['reason'], json['date'], json['time']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'reason': reason, 'date': date, 'time': time};
}

class ClinicList {      
  String id,name,address;
  double rate;  
  List<BookingList> bookingList;

  ClinicList(this.id,this.name,this.rate,this.address,this.bookingList);
  ClinicList.copy(ClinicList from): this(from.id,from.name,from.rate,from.address,from.bookingList);

  ClinicList.fromJson(Map<String, dynamic> json)
      : this(
            json['id'],json['name'], json['rate'], json['address'], (json['bookingList'] as List).map((item) => BookingList.fromJson(item)).toList());

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'rate': rate, 'address': address, 'bookingList': bookingList};
}