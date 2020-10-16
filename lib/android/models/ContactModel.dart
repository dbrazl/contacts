class ContactModel {
  String name;
  String phone;
  String mail;
  String photo;
  String address;
  String neighborhood;
  double latitude;
  double longitude;

  ContactModel(
      {this.name,
      this.phone,
      this.mail,
      this.photo,
      this.address,
      this.neighborhood,
      this.latitude,
      this.longitude});

  ContactModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.phone = json['phone'];
    this.mail = json['mail'];
    this.photo = json['photo'];
    this.address = json['address'];
    this.neighborhood = json['neighborhood'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['mail'] = this.mail;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['neighborhood'] = this.neighborhood;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
