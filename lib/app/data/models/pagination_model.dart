/// 分页数据模型
class PaginationModel<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int pageSize;
  final bool hasNext;
  final bool hasPrevious;

  PaginationModel({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.pageSize,
  })  : hasNext = currentPage < totalPages,
        hasPrevious = currentPage > 1;

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return PaginationModel<T>(
      items: (json['items'] as List?)
              ?.map((item) => fromJsonT(item))
              .toList() ??
          [],
      currentPage: json['current_page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      totalItems: json['total_items'] as int? ?? 0,
      pageSize: json['page_size'] as int? ?? 20,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'items': items.map((item) => toJsonT(item)).toList(),
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_items': totalItems,
      'page_size': pageSize,
    };
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
}
