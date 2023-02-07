import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/http/api_provider.dart';
import 'package:task/feature/news/cubit/news_cubit.dart';
import 'package:task/feature/news/resource/news_repository.dart';
import 'package:task/feature/news/ui/page/news_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(),
          lazy: true,
        ),
        RepositoryProvider(
            create: ((context) => NewsRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context))))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => NewsCubit(
                newsRepository: RepositoryProvider.of<NewsRepository>(context))
              ..getNews()),
          )
        ],
        child: MaterialApp(
          home: const NewsPage(),
          theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white)),
        ),
      ),
    );
  }
}
