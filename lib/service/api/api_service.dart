import 'package:carx/model/brand.dart';
import 'package:carx/model/car.dart';
import 'package:carx/service/api/api_provider.dart';
import 'package:carx/service/api/http_api_provider.dart';

const SERVER_NAME = 'https://flexicarrent.000webhostapp.com';
const URL_REGISTER = '$SERVER_NAME/users/register.php';

class ApiService implements ApiProvider {
  final ApiProvider apiProvider;
  const ApiService({required this.apiProvider});
  factory ApiService.fromApi() => ApiService(apiProvider: HttpApiProvider());

  @override
  Future<void> createUser({
    required String id,
    required String name,
    required String email,
  }) =>
      apiProvider.createUser(id: id, name: name, email: email);
  @override
  Future<void> createUserWithGoogle({
    required String id,
    String? name,
    String? email,
    String? image,
  }) =>
      apiProvider.createUserWithGoogle(
          id: id, email: email, image: image, name: name);

  @override
  Future<List<Brand>> fetchBrands() => apiProvider.fetchBrands();

  @override
  Future<List<Car>> fetchCars() => apiProvider.fetchCars();
}
