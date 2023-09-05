class Contact {
  Contact({required this.phone, required this.fullname});
  late final String phone;
  late final String fullname;
  late int id;

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    fullname = json['fullname'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phone'] = phone;
    data['fullname'] = fullname;
    return data;
  }
}
