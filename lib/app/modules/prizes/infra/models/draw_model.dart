import '../../../../shared/utils.dart';

class DrawModel {
  final String giftPhoto;
  final String mallName;
  final String code;
  final String id;
  final String name;
  final String gift;
  final String giftId;
  final DateTime expireAt;
  final DateTime createdAt;

  DrawModel({
    required this.giftPhoto,
    required this.mallName,
    required this.code,
    required this.id,
    required this.name,
    required this.gift,
    required this.giftId,
    required this.expireAt,
    required this.createdAt,
  });

  factory DrawModel.empty() {
    return DrawModel(
      giftPhoto: "",
      mallName: "",
      code: "",
      id: "",
      name: "",
      gift: "",
      giftId: "",
      expireAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }

  factory DrawModel.fromJson(Map<String, dynamic> json) {
    return DrawModel(
      giftPhoto: json['giftPhoto'],
      mallName: json['mallName'],
      code: json['code'],
      id: json['id'],
      name: json['name'],
      gift: json['gift'],
      giftId: json['giftId'],
      expireAt: getDate(json['expireAt']) ?? DateTime.now(),
      createdAt: getDate(json['createdAt']) ?? DateTime.now(),
    );
  }
}
