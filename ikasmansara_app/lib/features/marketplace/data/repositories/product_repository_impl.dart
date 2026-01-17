import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getProducts({
    String? category,
    String? query,
    int page = 1,
    int limit = 20,
  }) async {
    return await remoteDataSource.getProducts(
      category: category,
      query: query,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<ProductEntity> getProductDetail(String id) async {
    return await remoteDataSource.getProductDetail(id);
  }

  @override
  Future<void> createProduct(ProductEntity product, dynamic imageFile) async {
    // TODO: Implement create product logic in data source
    throw UnimplementedError();
  }
}
