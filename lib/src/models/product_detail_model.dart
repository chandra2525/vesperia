class ProductDetailModel {
  ProductDetailModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.type,
    required this.position,
    required this.isMenu,
  });

  final String id;
  final String name;
  final String icon;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final String type;
  final int position;
  final bool isMenu;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        status: json['status'],
        type: json['type'],
        position: json['position'],
        isMenu: json['is_menu'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'status': status,
        'type': type,
        'position': position,
        'is_menu': isMenu,
      };
}
