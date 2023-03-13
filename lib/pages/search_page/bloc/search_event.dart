part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  String searchValue;

  SearchEvent([this.searchValue = ""]);

  @override
  // TODO: implement props
  List<Object?> get props => [searchValue];
}
