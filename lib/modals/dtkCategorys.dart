// To parse this JSON data, do
//
//     final dtkCategory = dtkCategoryFromJson(jsonString);

import 'dart:convert';

DtkCategory dtkCategoryFromJson(String str) => DtkCategory.fromJson(json.decode(str));

String dtkCategoryToJson(DtkCategory data) => json.encode(data.toJson());

class DtkCategory {
  int time;
  int code;
  String msg;
  List<CategoryItem> data;

  DtkCategory({
    this.time,
    this.code,
    this.msg,
    this.data,
  });

  factory DtkCategory.fromJson(Map<String, dynamic> json) => DtkCategory(
    time: json["time"],
    code: json["code"],
    msg: json["msg"],
    data: List<CategoryItem>.from(json["data"].map((x) => CategoryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryItem {
  int cid;
  String cname;
  String cpic;
  List<Subcategory> subcategories;

  CategoryItem({
    this.cid,
    this.cname,
    this.cpic,
    this.subcategories,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
    cid: json["cid"],
    cname: json["cname"],
    cpic: json["cpic"],
    subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "cname": cname,
    "cpic": cpic,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
  };
}

class Subcategory {
  int subcid;
  String subcname;
  String scpic;

  Subcategory({
    this.subcid,
    this.subcname,
    this.scpic,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    subcid: json["subcid"],
    subcname: json["subcname"],
    scpic: json["scpic"],
  );

  Map<String, dynamic> toJson() => {
    "subcid": subcid,
    "subcname": subcname,
    "scpic": scpic,
  };
}
