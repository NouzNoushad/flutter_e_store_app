import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/colors.dart';
import '../cubit/store_cubit.dart';
import 'widgets/text_logo.dart';

class ProductScreen extends StatelessWidget {
  final categories;
  const ProductScreen({super.key, this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.8),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: primaryColor,
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: amberColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const LogoText(
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: BlocConsumer<StoreCubit, StoreState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                StoreCubit cubit = StoreCubit.getContext(context);

                if (cubit.isLoading) {
                  cubit.fetchProducts(categories);
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: amberColor,
                      color: primaryColor,
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Animate(
                      effects: const [
                        FadeEffect(
                            delay: Duration(milliseconds: 800),
                            duration: Duration(seconds: 1))
                      ],
                      child: ListView.builder(
                        itemCount: cubit.products!.length,
                        itemBuilder: (context, index) {
                          var product = cubit.products![index];
                          print(product);
                          return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(children: [
                                  Container(
                                    // height: 100,
                                    width: 100,
                                    child: Image.network(
                                      product.thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            product.brand,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '\$${product.price}',
                                            style: const TextStyle(
                                              color: Colors.amber,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            product.description,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ]),
                              ));
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
