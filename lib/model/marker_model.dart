class MarkerModel {
  String? event;
  Data? data;

  MarkerModel({this.event, this.data});

  MarkerModel.fromJson(Map<String, dynamic> json) {
    event = json['$event'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$event'] = this.event;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? x;
  int? y;
  double? lon;
  double? lat;

  Data({this.x, this.y, this.lon, this.lat});

  Data.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}
