/// 基础模型接口
abstract class BaseModel {
  /// 从 JSON 反序列化
  Map<String, dynamic> toJson();

  /// 转为 JSON 序列化
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be implemented');
  }
}
