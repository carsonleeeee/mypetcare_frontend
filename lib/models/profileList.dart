class ProfileList {
  String phone,email,pet,petname;

  ProfileList(this.phone,this.email,this.pet,this.petname);
  ProfileList.copy(ProfileList from): this(from.phone,from.email,from.pet,from.petname);
}