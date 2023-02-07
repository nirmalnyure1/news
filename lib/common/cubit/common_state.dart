import 'package:equatable/equatable.dart';

class CommonState extends Equatable {
  const CommonState({this.statusCode});
  final int? statusCode;
  @override
  List<Object?> get props => [];
}

class CommonInitial extends CommonState {}

class CommonLoading extends CommonState {}

class CommonDummyLoading extends CommonState {}

class CommonNoData extends CommonState {
  const CommonNoData();
  @override
  List<Object?> get props => [];
}

class CommonError extends CommonState {
  final String message;
  const CommonError({required this.message, int? statusCode})
      : super(statusCode: statusCode);
  bool get isNoConnection => statusCode == 1000;
  @override
  List<Object?> get props => [message];
}

class CommonStateSuccess<T> extends CommonState {
  final T data;
  const CommonStateSuccess({required this.data});
  List<Object?> get props => [data];
}
