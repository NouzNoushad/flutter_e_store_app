part of 'store_cubit.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class FetchCategoriesSuccess extends StoreState{}

class FetchCategoriesFailed extends StoreState {}

class FetchProductLoading extends StoreState{}

class FetchProductsSuccess extends StoreState{}

class FetchProductsFailed extends StoreState {}

class BaseClientError extends StoreState{}

class FindCurrentLocationSuccess extends StoreState{}