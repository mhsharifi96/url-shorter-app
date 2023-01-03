import 'dart:convert';

class LinkModel {
  LinkModel({
    required this.main_link,
     this.short_link,
  });

  String main_link;
  String? short_link;

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
    main_link: json["main_link"],
    short_link: json["short_link"] ?? '',

  );

  Map<String, dynamic> toJson() => {
    "main_link": main_link,
    "short_link": short_link ?? '',

  };
}