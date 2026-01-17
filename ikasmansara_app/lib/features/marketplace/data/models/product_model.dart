import 'package:pocketbase/pocketbase.dart';
import '../../domain/entities/product_entity.dart';
import '../../../auth/data/models/user_model.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.category,
    required super.images,
    required super.whatsapp,
    required super.sellerId,
    super.seller,
    required super.created,
  });

  factory ProductModel.fromRecord(RecordModel record) {
    // Check if seller is expanded
    UserModel? sellerModel;
    // Check if expands exists and contains seller using generic get method or direct map access map
    // PocketBase v0.20+ uses expand map directly or generic get.
    // The lint error suggests 'expand' field is deprecated and we should use record.get<T>('expand.something')
    // But expanding is a bit tricky with the generic get if we want the map.
    // Let's use get<List<RecordModel>>('expand.seller')

    // Attempt to access expanded seller safely
    try {
      final expandedSeller = record.expand['seller'];
      if (expandedSeller != null && expandedSeller.isNotEmpty) {
        sellerModel = UserModel.fromRecord(expandedSeller.first);
      }
    } catch (_) {
      // Fallback or ignore if expand structure is different
    }

    return ProductModel(
      id: record.id,
      title: record.getStringValue('title'),
      description: record.getStringValue('description'),
      price: record.getDoubleValue('price'),
      category: record.getStringValue('category'),
      images: record.getListValue<String>('images'),
      whatsapp: record.getStringValue('whatsapp'),
      sellerId: record.getStringValue('seller'),
      seller: sellerModel,
      created: DateTime.parse(record.getStringValue('created')),
    );
  }

  /// Helper to get full image URL
  String getImageUrl(String baseUrl, String filename) {
    return '$baseUrl/api/files/products/$id/$filename';
  }
}
