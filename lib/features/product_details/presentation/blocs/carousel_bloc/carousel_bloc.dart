import 'dart:async';

import 'package:eshop/features/product_details/presentation/blocs/carousel_bloc/carousel_events.dart';
import 'package:eshop/features/product_details/presentation/blocs/carousel_bloc/carousel_sates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselStates> {
  CarouselBloc() : super(CarouselImagesChangeState(currentIndex: 0)) {
    on<ChangeImageEvent>(changeImage);
  }

  FutureOr<void> changeImage(
    ChangeImageEvent event,
    Emitter<CarouselStates> emit,
  ) {
    emit(CarouselImagesChangeState(currentIndex: event.index));
  }
}
