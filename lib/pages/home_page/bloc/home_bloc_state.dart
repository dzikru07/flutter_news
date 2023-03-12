part of 'home_bloc_bloc.dart';

@immutable
abstract class HomeBlocState extends Equatable {}

class HomeBlocInitial extends HomeBlocState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListNewsLoaded extends HomeBlocState {
  NewsListModels listData;

  ListNewsLoaded(this.listData);

  @override
  // TODO: implement props
  List<Object?> get props => [listData];
}

class ListNewsError extends HomeBlocState {
  String message;

  ListNewsError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ListNewsLoading extends HomeBlocState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
