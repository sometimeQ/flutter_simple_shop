// To parse this JSON data, do
//
//     final carouselRes = carouselResFromJson(jsonString);

import 'dart:convert';

CarouselRes carouselResFromJson(String str) => CarouselRes.fromJson(json.decode(str));

String carouselResToJson(CarouselRes data) => json.encode(data.toJson());

class CarouselRes {
    int code;
    String msg;
    List<Datum> data;

    CarouselRes({
        this.code,
        this.msg,
        this.data,
    });

    factory CarouselRes.fromJson(Map<String, dynamic> json) => CarouselRes(
        code: json["code"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    String url;
    String type;
    String view;
    int clickCount;
    String remark;
    String src;

    Datum({
        this.id,
        this.name,
        this.url,
        this.type,
        this.view,
        this.clickCount,
        this.remark,
        this.src,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        type: json["type"],
        view: json["view"],
        clickCount: json["clickCount"],
        remark: json["remark"],
        src: json["src"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "type": type,
        "view": view,
        "clickCount": clickCount,
        "remark": remark,
        "src": src,
    };
}
