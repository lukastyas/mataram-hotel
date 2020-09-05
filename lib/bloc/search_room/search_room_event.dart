part of 'search_room_bloc.dart';

abstract class SearchRoomEvent extends Equatable{
  const SearchRoomEvent();
}
class LoadRoom extends SearchRoomEvent {

  @override
  List<Object> get props => [];
}

class OnChangeDate extends SearchRoomEvent {
  @override
  List<Object> get props => [];
}