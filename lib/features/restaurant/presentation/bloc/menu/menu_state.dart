part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  const MenuState();
  @override
  List<Object> get props => [];
}

class InitialMenuState extends MenuState {
  const InitialMenuState();
  @override
  List<Object> get props => [];
}

class LoadingMenuState extends MenuState {
  const LoadingMenuState();
  @override
  List<Object> get props => [];
}

class FailedMenuState extends MenuState {
  final String message;
  const FailedMenuState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchedMenuState extends MenuState {
  final List<Menu> menu;
  const FetchedMenuState(this.menu);
  @override
  List<Object> get props => [menu];
}
