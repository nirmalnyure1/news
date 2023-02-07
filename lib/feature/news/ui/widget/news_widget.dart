import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task/common/cubit/common_state.dart';
import 'package:task/common/widget/common_button.dart';
import 'package:task/common/widget/common_dropdown_widget.dart';
import 'package:task/feature/news/constant/constants.dart';
import 'package:task/feature/news/cubit/news_cubit.dart';
import 'package:task/feature/news/model/news_model.dart';
import 'package:task/feature/news/resource/news_repository.dart';
import 'package:task/feature/news/ui/widget/clear_filter_widget.dart';
import 'package:task/feature/news/ui/widget/news_grid_view.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  String? selectedMonth;
  String? selectedYear;

  List<String> year = [];
  List<String> months = [];

  @override
  void initState() {
    year = Year.getListYear;
    months = Months.monthsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsRepository = RepositoryProvider.of<NewsRepository>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<NewsCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CommonError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 20),
                  CommonButton(
                    onPressed: () {
                      context.read<NewsCubit>().getNews();
                    },
                    title: "reload",
                  )
                ],
              ),
            );
          }

          if (state is CommonStateSuccess) {
            final newsList = state.data as List<List<NewsModel>>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomScrollView(
                slivers: [
                  SliverPinnedHeader(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).padding.top + 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CommonDropDownWidget(
                                selectedValue: selectedMonth,
                                dropDownItem: months,
                                hintText: "Months",
                                onChange: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedMonth = value;

                                      if (selectedYear != null) {
                                        newsRepository.getNewsByTime(
                                            months: Months.month.keys
                                                .firstWhere((element) =>
                                                    Months.month[element] ==
                                                    selectedMonth),
                                            year: int.parse(selectedYear!));
                                      }
                                    }
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              CommonDropDownWidget(
                                selectedValue: selectedYear,
                                dropDownItem: year,
                                hintText: "Years",
                                onChange: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      selectedYear = value;
                                      if (selectedMonth != null) {
                                        newsRepository.getNewsByTime(
                                            months: Months.month.keys
                                                .firstWhere((element) =>
                                                    Months.month[element] ==
                                                    selectedMonth),
                                            year: int.parse(selectedYear!));
                                      }
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (selectedMonth != null || selectedYear != null)
                    SliverPinnedHeader(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClearFilderWidget(onPressed: () {
                            selectedMonth = null;
                            selectedYear = null;
                            setState(() {});
                          }),
                        ],
                      ),
                    ),
                  if (selectedMonth != null && selectedYear != null)
                    SliverToBoxAdapter(
                      child: NewsGridWithHeader(
                          title: newsRepository.filterNews.isNotEmpty
                              ? "${newsRepository.filterNews.length} news found "
                              : "news not found",
                          newsList: newsRepository.filterNews),
                    ),
                  if (selectedMonth == null && selectedYear == null)
                    SliverToBoxAdapter(
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        physics: const ScrollPhysics(),
                        children: List.generate(
                            newsList.length,
                            (index) => NewsGridWithHeader(
                                  title:
                                      "${newsList[index][0].publishedMonth}, ${newsList[index][0].publishedYear}",
                                  newsList: newsList[index].reversed.toList(),
                                )),
                      ),
                    ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
