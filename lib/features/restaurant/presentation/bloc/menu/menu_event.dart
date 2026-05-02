part of 'menu_bloc.dart';

sealed class MenuEvent {
  const MenuEvent();
}

class FetchMenuEvent extends MenuEvent {
  final int id;
  const FetchMenuEvent(this.id);
}
