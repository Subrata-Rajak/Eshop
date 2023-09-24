abstract class CarouselStates {}

class CarouselImagesChangeState extends CarouselStates {
  final int currentIndex;

  CarouselImagesChangeState({required this.currentIndex});
}
