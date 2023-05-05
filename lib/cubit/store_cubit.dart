import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/categories_response.dart';
import '../model/products_response.dart';
import '../network/endpoint.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreInitial());

  static StoreCubit getContext(context) => BlocProvider.of(context);

  var baseClient = http.Client();
  var baseHeader = {'content-type': 'application/json'};
  List categories = [];
  List<Product>? products;
  bool isLoading = true;
  Placemark? place;

  Future<dynamic> get(String endpoint, [Map<String, String>? header]) async {
    try {
      var uri = Uri.parse(endpoint);
      var response = await baseClient.get(uri, headers: header ?? baseHeader);
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('error');
        emit(FetchCategoriesFailed());
      }
    } catch (err) {
      print(err);
      emit(BaseClientError());
    }
  }

  fetchProductCategories() async {
    var response = await get(ApiEndpoint.categories);
    if (response == null) {
      // print('error');
      emit(FetchCategoriesFailed());
    } else {
      print(response);
      categories = productsCategoriesResponseModelFromJson(response);
      emit(FetchCategoriesSuccess());
    }
  }

  fetchProducts(category) async {
    var response =
        await get('https://dummyjson.com/products/category/$category');
    if (response == null) {
      // print('error');
      isLoading = false;
      emit(FetchProductsFailed());
    } else {
      isLoading = false;
      print('product response: $response');
      ProductsResponseModel responseProducts;
      responseProducts = productsResponseModelFromJson(response);
      products = responseProducts.products
          .where((product) => product.category == category)
          .toList();
      print(products);
      emit(FetchProductsSuccess());
    }
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((placemarks) {
      place = placemarks[0];

      emit(FindCurrentLocationSuccess());
    });
  }
}
