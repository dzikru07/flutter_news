part of 'home_bloc_bloc.dart';

@immutable
class HomeBlocEvent extends Equatable {
  String searchValue;

  HomeBlocEvent([this.searchValue = ""]);

  @override
  // TODO: implement props
  List<Object?> get props => [searchValue];
}
