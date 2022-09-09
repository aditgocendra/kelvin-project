// Note : Variant product required in product data (at least 1)
class VariantProductModel {
  String color;
  String size;
  int stock;
  String? idDocument;

  VariantProductModel({
    required this.color,
    required this.size,
    required this.stock,
  });

  VariantProductModel.fromJson(Map<String, Object?> json)
      : this(
          color: json['color']! as String,
          size: json['size']! as String,
          stock: json['stock']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'color': color,
      'size': size,
      'stock': stock,
    };
  }

  String variantAsString() {
    return '$color | $size';
  }

  bool isEqual(VariantProductModel model) {
    return idDocument == model.idDocument;
  }
}
