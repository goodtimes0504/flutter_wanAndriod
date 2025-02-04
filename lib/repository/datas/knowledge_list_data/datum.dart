import 'child.dart';

class Datum {
  List<dynamic>? articleList;
  String? author;
  List<Child>? children;
  int? courseId;
  String? cover;
  String? desc;
  int? id;
  String? lisense;
  String? lisenseLink;
  String? name;
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  Datum({
    this.articleList,
    this.author,
    this.children,
    this.courseId,
    this.cover,
    this.desc,
    this.id,
    this.lisense,
    this.lisenseLink,
    this.name,
    this.order,
    this.parentChapterId,
    this.type,
    this.userControlSetTop,
    this.visible,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        articleList: json['articleList'] as List<dynamic>?,
        author: json['author'] as String?,
        children: (json['children'] as List<dynamic>?)
            ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
            .toList(),
        courseId: json['courseId'] as int?,
        cover: json['cover'] as String?,
        desc: json['desc'] as String?,
        id: json['id'] as int?,
        lisense: json['lisense'] as String?,
        lisenseLink: json['lisenseLink'] as String?,
        name: json['name'] as String?,
        order: json['order'] as int?,
        parentChapterId: json['parentChapterId'] as int?,
        type: json['type'] as int?,
        userControlSetTop: json['userControlSetTop'] as bool?,
        visible: json['visible'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'articleList': articleList,
        'author': author,
        'children': children?.map((e) => e.toJson()).toList(),
        'courseId': courseId,
        'cover': cover,
        'desc': desc,
        'id': id,
        'lisense': lisense,
        'lisenseLink': lisenseLink,
        'name': name,
        'order': order,
        'parentChapterId': parentChapterId,
        'type': type,
        'userControlSetTop': userControlSetTop,
        'visible': visible,
      };
}
