import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<Image> carouselImages;

  const HomeLoaded({
    required this.carouselImages,
  });

  HomeLoaded copyWith({
    List<Image>? carouselImages,
  }) {
    return HomeLoaded(
      carouselImages: carouselImages ?? this.carouselImages,
    );
  }

  @override
  List<Object?> get props => [carouselImages];
}