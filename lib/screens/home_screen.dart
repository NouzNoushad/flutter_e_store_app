import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_store/screens/products_screen.dart';

import '../core/colors.dart';
import '../cubit/store_cubit.dart';
import 'widgets/text_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: primaryColor,
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: const [
                    LogoText(
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
                  if (state is BaseClientError) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: amberColor,
                        content: Text(
                          'Please check your internet connect and try again',
                        )));
                  }
                  if (state is FetchCategoriesFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: amberColor,
                        content: Text(
                          'Something went wrong, cannot fetch the data',
                        )));
                  }
                },
                builder: (context, state) {
                  StoreCubit cubit = StoreCubit.getContext(context);
                  print(cubit.place);
                  if (state is StoreInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: amberColor,
                        color: primaryColor,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Material(
                          color: whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Current Location:',
                                  ),
                                  Text(
                                    cubit.place != null
                                        ? cubit.place!.locality.toString()
                                        : '',
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: lightPrimaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            child: Animate(
                              effects: const [
                                FadeEffect(
                                    delay: Duration(milliseconds: 800),
                                    duration: Duration(seconds: 1))
                              ],
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 6,
                                        crossAxisSpacing: 6,
                                        childAspectRatio: 4 / 3),
                                itemCount: cubit.categories.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                  categories:
                                                      cubit.categories[index],
                                                )));
                                    cubit.isLoading = true;
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          cubit.categories[index]
                                              .toString()
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 16, color: whiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
