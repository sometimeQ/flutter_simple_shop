// To parse this JSON data, do
//
//     final indexData = indexDataFromJson(jsonString);

import 'dart:convert';


IndexData indexDataFromJson(String str) => IndexData.fromJson(json.decode(str));

String indexDataToJson(IndexData data) => json.encode(data.toJson());

class IndexData {
  List<Category> categorys;
  int current;
  int total;
  List<Time> times;
  List<RecentComment> recentComments;
  Pager pager;
  List<RecentPost> recentPosts;
  List<Dtolist> dtolist;
  List<Tag> tags;

  IndexData({
    this.categorys,
    this.current,
    this.total,
    this.times,
    this.recentComments,
    this.pager,
    this.recentPosts,
    this.dtolist,
    this.tags,
  });

  factory IndexData.fromJson(Map<String, dynamic> json) => IndexData(
    categorys: List<Category>.from(json["categorys"].map((x) => Category.fromJson(x))),
    current: json["current"],
    total: json["total"],
    times: List<Time>.from(json["times"].map((x) => Time.fromJson(x))),
    recentComments: List<RecentComment>.from(json["RecentComments"].map((x) => RecentComment.fromJson(x))),
    pager: Pager.fromJson(json["pager"]),
    recentPosts: List<RecentPost>.from(json["RecentPosts"].map((x) => RecentPost.fromJson(x))),
    dtolist: List<Dtolist>.from(json["dtolist"].map((x) => Dtolist.fromJson(x))),
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categorys": List<dynamic>.from(categorys.map((x) => x.toJson())),
    "current": current,
    "total": total,
    "times": List<dynamic>.from(times.map((x) => x.toJson())),
    "RecentComments": List<dynamic>.from(recentComments.map((x) => x.toJson())),
    "pager": pager.toJson(),
    "RecentPosts": List<dynamic>.from(recentPosts.map((x) => x.toJson())),
    "dtolist": List<dynamic>.from(dtolist.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
  };
}

class Category {
  String categoryName;
  int categoryId;
  int size;

  Category({
    this.categoryName,
    this.categoryId,
    this.size,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryName: json["categoryName"],
    categoryId: json["categoryId"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "categoryId": categoryId,
    "size": size,
  };
}

class Dtolist {
  int id;
  String title;
  String category;
  String categoryId;
  int createTime;
  String content;
  String author;
  String authorHeader;
  List<Tag> tags;
  String cover;

  Dtolist({
    this.id,
    this.title,
    this.category,
    this.categoryId,
    this.createTime,
    this.content,
    this.author,
    this.authorHeader,
    this.tags,
    this.cover,
  });

  factory Dtolist.fromJson(Map<String, dynamic> json) => Dtolist(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    categoryId: json["categoryId"],
    createTime: json["createTime"],
    content: json["content"],
    author: json["author"],
    authorHeader: json["authorHeader"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    cover: json["cover"] == null ? null : json["cover"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "categoryId": categoryId,
    "createTime": createTime,
    "content": content,
    "author": author,
    "authorHeader": authorHeader,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "cover": cover == null ? null : cover,
  };
}

class Tag {
  int id;
  String name;
  int count;

  Tag({
    this.id,
    this.name,
    this.count,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "count": count == null ? null : count,
  };
}

class Pager {
  int current;
  int pages;
  int size;
  int total;

  Pager({
    this.current,
    this.pages,
    this.size,
    this.total,
  });

  factory Pager.fromJson(Map<String, dynamic> json) => Pager(
    current: json["current"],
    pages: json["pages"],
    size: json["size"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "pages": pages,
    "size": size,
    "total": total,
  };
}

class RecentComment {
  dynamic id;
  String articleTitle;
  int articleId;
  String name;
  dynamic time;
  String content;
  dynamic email;
  dynamic url;
  dynamic ip;
  dynamic device;
  dynamic address;
  dynamic sort;
  dynamic cid;
  dynamic cname;
  dynamic pid;

  RecentComment({
    this.id,
    this.articleTitle,
    this.articleId,
    this.name,
    this.time,
    this.content,
    this.email,
    this.url,
    this.ip,
    this.device,
    this.address,
    this.sort,
    this.cid,
    this.cname,
    this.pid,
  });

  factory RecentComment.fromJson(Map<String, dynamic> json) => RecentComment(
    id: json["id"],
    articleTitle: json["articleTitle"],
    articleId: json["articleId"],
    name: json["name"],
    time: json["time"],
    content: json["content"],
    email: json["email"],
    url: json["url"],
    ip: json["ip"],
    device: json["device"],
    address: json["address"],
    sort: json["sort"],
    cid: json["cid"],
    cname: json["cname"],
    pid: json["pid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "articleTitle": articleTitle,
    "articleId": articleId,
    "name": name,
    "time": time,
    "content": content,
    "email": email,
    "url": url,
    "ip": ip,
    "device": device,
    "address": address,
    "sort": sort,
    "cid": cid,
    "cname": cname,
    "pid": pid,
  };
}

class RecentPost {
  int id;
  String title;
  String cover;
  String author;
  dynamic content;
  dynamic contentMd;
  String category;
  String state;
  DateTime publishTime;
  DateTime editTime;
  DateTime createTime;
  dynamic tags;

  RecentPost({
    this.id,
    this.title,
    this.cover,
    this.author,
    this.content,
    this.contentMd,
    this.category,
    this.state,
    this.publishTime,
    this.editTime,
    this.createTime,
    this.tags,
  });

  factory RecentPost.fromJson(Map<String, dynamic> json) => RecentPost(
    id: json["id"],
    title: json["title"],
    cover: json["cover"] == null ? null : json["cover"],
    author: json["author"] == null ? null : json["author"],
    content: json["content"],
    contentMd: json["contentMd"],
    category: json["category"] == null ? null : json["category"],
    state: json["state"] == null ? null : json["state"],
    publishTime: json["publishTime"] == null ? null : DateTime.parse(json["publishTime"]),
    editTime: json["editTime"] == null ? null : DateTime.parse(json["editTime"]),
    createTime: DateTime.parse(json["createTime"]),
    tags: json["tags"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "cover": cover == null ? null : cover,
    "author": author == null ? null : author,
    "content": content,
    "contentMd": contentMd,
    "category": category == null ? null : category,
    "state": state == null ? null : state,
    "publishTime": publishTime == null ? null : publishTime.toIso8601String(),
    "editTime": editTime == null ? null : editTime.toIso8601String(),
    "createTime": createTime.toIso8601String(),
    "tags": tags,
  };
}

class Time {
  String date;
  List<RecentPost> articles;

  Time({
    this.date,
    this.articles,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    date: json["date"],
    articles: List<RecentPost>.from(json["articles"].map((x) => RecentPost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}
