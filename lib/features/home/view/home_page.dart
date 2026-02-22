import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamers_brew/core/theme/app_colors.dart';
import 'package:gamers_brew/core/widgets/choise_hor_slidebar.dart';
import 'package:gamers_brew/core/widgets/coffee_product_card.dart';
import 'package:gamers_brew/features/cart/bloc/cart_bloc.dart';
import 'package:gamers_brew/features/cart/bloc/cart_state.dart';
import 'package:gamers_brew/features/home/bloc/home_bloc.dart';
import 'package:gamers_brew/features/home/bloc/home_state.dart';
import 'package:gamers_brew/features/home/bloc/product_bloc.dart';
import 'package:gamers_brew/features/home/bloc/product_event.dart';
import 'package:gamers_brew/features/home/bloc/product_state.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) return const SizedBox.shrink();

          return FloatingActionButton(
            onPressed: () => context.push('/cart'),
            backgroundColor: AppColors.primary,
            elevation: 10,
            shape: const CircleBorder(),
            child: Icon(Icons.shopping_cart, size: 35, color: Colors.white),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 60.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.sports_esports, color: AppColors.primary),
                    const SizedBox(width: 10),
                    const Text(
                      "Gamer's Brew",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) return _buildPromoCarousel(state);
                return const SizedBox.shrink();
              },
            ),
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              String currentCategory = "Все";
              List<String> categories = [];

              if (state is ProductLoaded) {
                currentCategory = state.selectedCategory;
                categories = state.categories;
              } else if (state is ProductLoading) {
                currentCategory = state.selectedCategory;
                categories = state.categories;
              }
              return SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: HorSliderBar(
                        items: ["Все", ...categories],
                        activeCategory: currentCategory,
                        onCategoryChanged: (category) {
                          context.read<ProductBloc>().add(
                            ChangeCategory(category),
                          );
                        },
                      ),
                    ),
                  ),
                  if (state is ProductLoading)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  else if (state is ProductLoaded)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: _buildSliverCoffeeGrid(state),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCarousel(HomeLoaded state) {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0, autoPlay: true),
      items: state.carouselImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(image: i.image, fit: BoxFit.cover),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildSliverCoffeeGrid(ProductLoaded state) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180.0,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 0.6,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        return CoffeeProductCard(product: state.items[index]);
      }, childCount: state.items.length),
    );
  }
}
