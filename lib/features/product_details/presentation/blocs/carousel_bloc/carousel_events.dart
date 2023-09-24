abstract class CarouselEvent {}

class ChangeImageEvent extends CarouselEvent {
  final int index;

  ChangeImageEvent({required this.index});
}
