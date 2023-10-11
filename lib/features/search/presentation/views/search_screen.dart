import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/search/domain/entities/search_product_entity.dart';
import 'package:eshop/features/search/presentation/blocs/search_product_screen_bloc/search_product_screen_bloc.dart';
import 'package:eshop/features/search/presentation/blocs/search_product_screen_bloc/search_product_screen_events.dart';
import 'package:eshop/features/search/presentation/blocs/search_product_screen_bloc/search_product_screen_states.dart';
import 'package:eshop/features/search/presentation/widgets/searched_product_card.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/values/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with CommonWidgets {
  TextEditingController searchFieldController = TextEditingController();
  List<String> searchTags = [
    "Macbook",
    "Laptops",
    "Watches",
    "Bags",
    "Men's wear",
    "Women's wear",
    "Shoes",
    "Electronics",
  ];

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildBody(size),
    );
  }

  SafeArea buildBody(Size size) {
    return SafeArea(
      child: BlocProvider<SearchProductScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<SearchProductScreenBloc, SearchProductScreenStates>(
          builder: (context, state) {
            if (state is SearchingProductState) {
              return Container(
                padding: const EdgeInsets.all(20),
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    buildSearchBar(context),
                    verticalSpace(height: 25),
                    buildSearchTagsContainer(size),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Lottie.asset(
                            "assets/anim/loading_anim.json",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SearchSuccessfulState) {
              SearchedProductListEntity? searchedProductList =
                  state.searchedProductList;

              return Container(
                padding: const EdgeInsets.all(20),
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    buildSearchBar(context),
                    verticalSpace(height: 25),
                    buildSearchTagsContainer(size),
                    verticalSpace(height: 20),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SearchedProductCard(
                            searchedProduct:
                                searchedProductList.searchedProductList[index],
                            size: size,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return verticalSpace(height: 20);
                        },
                        itemCount:
                            searchedProductList!.searchedProductList.length,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SearchErrorState) {
              return Container(
                padding: const EdgeInsets.all(20),
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    buildSearchBar(context),
                    verticalSpace(height: 25),
                    buildSearchTagsContainer(size),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Lottie.asset(
                            "assets/anim/error.json",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(20),
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  buildSearchBar(context),
                  verticalSpace(height: 25),
                  buildSearchTagsContainer(size),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox buildSearchTagsContainer(Size size) {
    return SizedBox(
      width: size.width,
      child: Wrap(
        children: searchTags
            .map(
              (tag) => GestureDetector(
                onTap: () {
                  searchFieldController.text = tag;
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 10, bottom: 15),
                  decoration: BoxDecoration(
                    color: AppColors.colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(color: AppColors.colors.darkBlue),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  TextField buildSearchBar(BuildContext neededContext) {
    return TextField(
      controller: searchFieldController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.colors.darkBlue,
            width: 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.colors.darkBlue,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.colors.darkBlue,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        hintText: "Search (ex. macbook)",
        suffixIcon: GestureDetector(
          onTap: () {
            neededContext.read<SearchProductScreenBloc>().add(
                  SearchProductEvent(
                    tag: searchFieldController.text.toLowerCase(),
                  ),
                );
          },
          child: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: AppColors.colors.orange,
            size: 20,
          ),
        ),
      ),
    );
  }
}
