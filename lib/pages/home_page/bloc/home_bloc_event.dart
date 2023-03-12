part of 'home_bloc_bloc.dart';

@immutable
class HomeBlocEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeBlocEventWithSearch extends Equatable {
  String? searchValue = "";

  HomeBlocEventWithSearch([this.searchValue]);

  @override
  // TODO: implement props
  List<Object?> get props => [searchValue];
}
