class ProfileList {
  String phone,pet,petname;

  ProfileList(this.phone,this.pet,this.petname);
  ProfileList.copy(ProfileList from): this(from.phone,from.pet,from.petname);

  ProfileList.fromJson(Map<String, dynamic> json)
      : this(
            json['phone'], json['pet'], json['petname']);

  Map<String, dynamic> toJson() =>
      {'phone': phone, 'pet': pet, 'petname': petname};
}