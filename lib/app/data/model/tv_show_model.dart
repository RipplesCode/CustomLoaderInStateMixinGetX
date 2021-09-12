// To parse this JSON data, do
//
//     final tvShowModel = tvShowModelFromJson(jsonString);

import 'dart:convert';

TvShowModel tvShowModelFromJson(String str) =>
    TvShowModel.fromJson(json.decode(str));

String tvShowModelToJson(TvShowModel data) => json.encode(data.toJson());

class TvShowModel {
  TvShowModel({
    this.total,
    this.page,
    this.pages,
    this.tvShows,
  });

  String? total;
  int? page;
  int? pages;
  List<TvShow>? tvShows;

  factory TvShowModel.fromJson(Map<String, dynamic> json) => TvShowModel(
        total: json["total"],
        page: json["page"],
        pages: json["pages"],
        tvShows:
            List<TvShow>.from(json["tv_shows"].map((x) => TvShow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "pages": pages,
        "tv_shows": List<dynamic>.from(tvShows!.map((x) => x.toJson())),
      };
}

class TvShow {
  TvShow({
    this.id,
    this.name,
    this.permalink,
    this.startDate,
    this.endDate,
    this.country,
    this.network,
    this.status,
    this.imageThumbnailPath,
  });

  int? id;
  String? name;
  String? permalink;
  DateTime? startDate;
  DateTime? endDate;
  String? country;
  String? network;
  Status? status;
  String? imageThumbnailPath;

  factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
        id: json["id"],
        name: json["name"],
        permalink: json["permalink"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        country: json["country"],
        network: json["network"],
        status: statusValues.map![json["status"]],
        imageThumbnailPath: json["image_thumbnail_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "permalink": permalink,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "country": country,
        "network": network,
        "status": statusValues.reverse[status],
        "image_thumbnail_path": imageThumbnailPath,
      };
}

enum Status { RUNNING, ENDED, TO_BE_DETERMINED }

final statusValues = EnumValues({
  "Ended": Status.ENDED,
  "Running": Status.RUNNING,
  "To Be Determined": Status.TO_BE_DETERMINED
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
