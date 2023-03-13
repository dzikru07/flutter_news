part of 'search_bloc.dart';

abstract class SearchState extends Equatable {}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class ListNewsLoaded extends SearchState {
  NewsListModels listData;

  ListNewsLoaded(this.listData);

  @override
  // TODO: implement props
  List<Object?> get props => [listData];
}

class ListNewsError extends SearchState {
  String message;

  ListNewsError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ListNewsApiError extends SearchState {
  ErrorModels data;

  ListNewsApiError(this.data);

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ListNewsLoading extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
