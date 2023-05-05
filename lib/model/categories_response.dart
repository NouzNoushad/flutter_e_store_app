import 'dart:convert';

List<String> productsCategoriesResponseModelFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String productsCategoriesResponseModelToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
