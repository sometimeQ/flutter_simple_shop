
class User {
  int id;
  String password;
  String remark;
  String bloglink;
  String company;
  String nickname;
  String introduce;
  String jobname;
  String username;
  String salt;
  String avatar;

  User({
    this.id,
    this.password,
    this.remark,
    this.bloglink,
    this.company,
    this.nickname,
    this.introduce,
    this.jobname,
    this.username,
    this.salt,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    password: json["password"],
    remark: json["remark"],
    bloglink: json["bloglink"],
    company: json["company"],
    nickname: json["nickname"],
    introduce: json["introduce"],
    jobname: json["jobname"],
    username: json["username"],
    salt: json["salt"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "password": password,
    "remark": remark,
    "bloglink": bloglink,
    "company": company,
    "nickname": nickname,
    "introduce": introduce,
    "jobname": jobname,
    "username": username,
    "salt": salt,
    "avatar": avatar,
  };
}