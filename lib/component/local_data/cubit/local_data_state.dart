part of 'local_data_cubit.dart';

abstract class LocalDataState extends Equatable {
  const LocalDataState();

  @override
  List<Object> get props => [];
}

class LocalDataInitial extends LocalDataState {

}

class LocalDataSuccess extends LocalDataState {
  List<ArticlesModel> listData;

  LocalDataSuccess(this.listData);

  @override
  List<Object> get props => [listData];
}


  