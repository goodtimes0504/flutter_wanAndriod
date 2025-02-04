class HotKeyItem {
  int? id;
  String? link;
  String? name;
  int? order;
  int? visible;

  HotKeyItem({this.id, this.link, this.name, this.order, this.visible});

  factory HotKeyItem.fromJson(Map<String, dynamic> json) => HotKeyItem(
        id: json['id'] as int?,
        link: json['link'] as String?,
        name: json['name'] as String?,
        order: json['order'] as int?,
        visible: json['visible'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'link': link,
        'name': name,
        'order': order,
        'visible': visible,
      };
}
