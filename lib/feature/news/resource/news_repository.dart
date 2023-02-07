import 'package:flutter/foundation.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:task/common/http/api_provider.dart';
import 'package:task/common/http/data_response.dart';
import 'package:task/feature/news/model/news_model.dart';
import 'package:task/feature/news/resource/news_api_provider.dart';

class NewsRepository {
  late NewsApiProvider newsApiProvider;
  final ApiProvider apiProvider;

  List<NewsModel> _news = [];

  final List<NewsModel> _filterNews = [];
  List<NewsModel> get filterNews => _filterNews;

  NewsRepository({required this.apiProvider}) {
    newsApiProvider = NewsApiProvider(apiProvider: apiProvider);
  }

  Future<DataResponse<List<List<NewsModel>>>> getNews() async {
    try {
      final res = await newsApiProvider.getNews();
      final temp = res['data']['data']['gorkhapatras'];
      _news = List.from(temp).map((e) => NewsModel.fromJson(e)).toList();

      List<List<NewsModel>> listoflist = [];
      List<NewsModel> tempList = [];

      _news.sort(((a, b) => b.publishedAt.compareTo(a.publishedAt)));

      NepaliDateTime datetime = _news[0].publishedAt;

      for (int i = 0; i < _news.length; i++) {
        if (datetime.year == _news[i].publishedAt.year &&
            datetime.month == _news[i].publishedAt.month) {
          tempList.add(_news[i]);
          if (_news.length - 1 == i) {
            listoflist.add(tempList);
            tempList = [];
          }
        } else {
          listoflist.add(tempList);
          tempList = [];
          datetime = _news[i].publishedAt;
          i--;
        }
      }

      debugPrint(listoflist.toString());

      return DataResponse.sucess(listoflist);
    } catch (e) {
      debugPrint(e.toString());
      return DataResponse.error(e.toString());
    }
  }

  void getNewsByTime({required int months, required int year}) {
    _filterNews.clear();
    for (int i = 0; i < _news.length; i++) {
      if (months == _news[i].publishedAt.month &&
          year == _news[i].publishedAt.year) {
        _filterNews.add(_news[i]);
      }
    }
  }
}
