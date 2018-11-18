// GENERATED CODE - DO NOT MODIFY BY HAND

part of datakick_sdk;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      json['gtin14'] as String,
      json['brand_name'] as String,
      json['name'] as String,
      json['size'] as String,
      json['ingredients'] as String,
      json['serving_size'] as String,
      json['servings_per_container'] as String,
      (json['calories'] as num)?.toDouble(),
      (json['fat_calories'] as num)?.toDouble(),
      (json['fat'] as num)?.toDouble(),
      (json['saturated_fat'] as num)?.toDouble(),
      (json['trans_fat'] as num)?.toDouble(),
      (json['polyunsaturated_fat'] as num)?.toDouble(),
      (json['monounsaturated_fat'] as num)?.toDouble(),
      (json['cholesterol'] as num)?.toDouble(),
      (json['sodium'] as num)?.toDouble(),
      (json['potassium'] as num)?.toDouble(),
      (json['carbohydrate'] as num)?.toDouble(),
      (json['fiber'] as num)?.toDouble(),
      (json['sugars'] as num)?.toDouble(),
      (json['protein'] as num)?.toDouble(),
      json['images'],
      json['author'] as String,
      json['format'] as String,
      json['publisher'] as String,
      json['pages'] as int,
      (json['alcohol_by_volume'] as num)?.toDouble());
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'gtin14': instance.gtin14,
      'brand_name': instance.brand_name,
      'name': instance.name,
      'size': instance.size,
      'ingredients': instance.ingredients,
      'serving_size': instance.serving_size,
      'servings_per_container': instance.servings_per_container,
      'calories': instance.calories,
      'fat_calories': instance.fat_calories,
      'fat': instance.fat,
      'saturated_fat': instance.saturated_fat,
      'trans_fat': instance.trans_fat,
      'polyunsaturated_fat': instance.polyunsaturated_fat,
      'monounsaturated_fat': instance.monounsaturated_fat,
      'cholesterol': instance.cholesterol,
      'sodium': instance.sodium,
      'potassium': instance.potassium,
      'carbohydrate': instance.carbohydrate,
      'fiber': instance.fiber,
      'sugars': instance.sugars,
      'protein': instance.protein,
      'alcohol_by_volume': instance.alcohol_by_volume,
      'author': instance.author,
      'format': instance.format,
      'publisher': instance.publisher,
      'pages': instance.pages,
      'images': instance.images
    };
