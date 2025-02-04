class Data {
  bool? admin;
  List<dynamic>? chapterTops;
  int? coinCount;
  List<dynamic>? collectIds;
  String? email;
  String? icon;
  int? id;
  String? nickname;
  String? password;
  String? publicName;
  String? token;
  int? type;
  String? username;

  Data({
    this.admin,
    this.chapterTops,
    this.coinCount,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        admin: json['admin'] as bool?,
        chapterTops: json['chapterTops'] as List<dynamic>?,
        coinCount: json['coinCount'] as int?,
        collectIds: json['collectIds'] as List<dynamic>?,
        email: json['email'] as String?,
        icon: json['icon'] as String?,
        id: json['id'] as int?,
        nickname: json['nickname'] as String?,
        password: json['password'] as String?,
        publicName: json['publicName'] as String?,
        token: json['token'] as String?,
        type: json['type'] as int?,
        username: json['username'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'admin': admin,
        'chapterTops': chapterTops,
        'coinCount': coinCount,
        'collectIds': collectIds,
        'email': email,
        'icon': icon,
        'id': id,
        'nickname': nickname,
        'password': password,
        'publicName': publicName,
        'token': token,
        'type': type,
        'username': username,
      };
}
