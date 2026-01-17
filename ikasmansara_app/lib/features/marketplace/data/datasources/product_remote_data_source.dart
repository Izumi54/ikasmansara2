import 'package:pocketbase/pocketbase.dart';
import 'package:ikasmansara_app/core/network/api_endpoints.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    String? category,
    String? query,
    int page = 1,
    int limit = 20,
  });

  Future<ProductModel> getProductDetail(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final PocketBase pb;

  ProductRemoteDataSourceImpl(this.pb);

  @override
  Future<List<ProductModel>> getProducts({
    String? category,
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    final filters = <String>[];

    // Filter by Category
    if (category != null && category.isNotEmpty && category != 'Semua') {
      filters.add('category = "$category"');
    }

    // Filter by Query (Title or Description)
    if (query != null && query.isNotEmpty) {
      filters.add('(title ~ "$query" || description ~ "$query")');
    }

    final filterString = filters.join(' && ');

    try {
      final result = await pb
          .collection(ApiEndpoints.products)
          .getList(
            page: page,
            perPage: limit,
            filter: filterString,
            sort: '-created',
            expand: 'seller', // Expand seller relation
          );

      return result.items.map((r) => ProductModel.fromRecord(r)).toList();
    } catch (e) {
      // Graceful degradation if Collection doesn't exist yet
      if (e is ClientException && e.statusCode == 404) {
        return [];
      }
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductDetail(String id) async {
    final record = await pb
        .collection(ApiEndpoints.products)
        .getOne(id, expand: 'seller');
    return ProductModel.fromRecord(record);
  }
}
