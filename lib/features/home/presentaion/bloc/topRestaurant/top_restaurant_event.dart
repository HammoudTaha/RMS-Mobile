part of 'top_restaurant_bloc.dart';

sealed class TopRestarantEvent {
  const TopRestarantEvent();
}

class FetchTopRestarantsEvent extends TopRestarantEvent {
  const FetchTopRestarantsEvent();
}
