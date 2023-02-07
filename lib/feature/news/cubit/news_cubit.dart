import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/cubit/common_state.dart';
import 'package:task/common/http/data_response.dart';
import 'package:task/feature/news/resource/news_repository.dart';

class NewsCubit extends Cubit<CommonState> {
  final NewsRepository newsRepository;
  NewsCubit({required this.newsRepository}) : super(CommonInitial());
  getNews() async {
    emit(CommonLoading());
    final res = await newsRepository.getNews();
    if (res.status == Status.success && res.data!.isNotEmpty) {
      emit(CommonStateSuccess(data: res.data));
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
