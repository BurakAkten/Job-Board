enum JobType { Normal, Accepted, Rejected }

class JobResponse {
  int? id;
  String? title;
  Address? pickup;
  Address? dropOff;
  DateTime? datePosted;
  DateTime? expectedDeliveryDate;
  JobType type = JobType.Normal;

  JobResponse.fromJson(dynamic json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    pickup = json['pickup'] != null ? Address.fromJson(json['pickup']) : null;
    dropOff = json['drop_off'] != null ? Address.fromJson(json['drop_off']) : null;
    datePosted = (json["date_posted"] == null || json["date_posted"].toString().isEmpty) ? null : DateTime.parse(json["date_posted"]);
    expectedDeliveryDate = (json["expected_delivery_date"] == null || json["expected_delivery_date"].toString().isEmpty)
        ? null
        : DateTime.parse(json["expected_delivery_date"]);
  }

  static List<JobResponse> listFromJson(List<dynamic>? json) {
    return json == null ? <JobResponse>[] : json.map((value) => JobResponse.fromJson(value)).toList();
  }
}

class Address {
  String? addressLine1;
  String? postcode;

  Address.fromJson(dynamic json) {
    if (json == null) return;

    addressLine1 = json['address_line_1'];
    postcode = json['postcode'];
  }
}
