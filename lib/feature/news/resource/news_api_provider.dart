import 'package:task/common/constant/api.dart';
import 'package:task/common/http/api_provider.dart';

class NewsApiProvider {
  final ApiProvider apiProvider;

  NewsApiProvider({required this.apiProvider});

 Future<dynamic> getNews() {
    final uri=Uri.parse("$baseUrl/gorkhapatras");
  return  apiProvider.get(uri);
  }
}
