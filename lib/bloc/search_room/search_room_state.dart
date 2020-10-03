part of 'search_room_bloc.dart';

@immutable
abstract class SearchRoomState {
  final DataSearch dataSearch;

  SearchRoomState({this.dataSearch});
}

class SearchRoomInitial extends SearchRoomState {
  final DataSearch dataSearch;

  SearchRoomInitial({this.dataSearch});
}

class RoomLoaded extends SearchRoomState {
  final List<RoomModel> room;
  final DataSearch dataSearch;

  RoomLoaded({this.room, this.dataSearch})
      : super(
          dataSearch: dataSearch,
        );
}

class DataSearch {
  DateTime selecetedDateFrom;
  DateTime selecetedDateTo;
  DateTime timeOfDay;
  final List<RoomModel> room;
  int adult;
  int children;
  int rooms;

  DataSearch(
      {this.adult = 1,
      this.children = 0,
      this.rooms = 1,
      this.room,
      this.timeOfDay,
      this.selecetedDateFrom,
      this.selecetedDateTo});

  DataSearch copyWith(DataSearch data) => DataSearch(
      room: data.room ?? this.room,
      selecetedDateFrom: data.selecetedDateFrom ?? this.selecetedDateFrom,
      timeOfDay: data.timeOfDay ?? this.timeOfDay,
      selecetedDateTo: data.selecetedDateTo ?? this.selecetedDateTo,
      adult: data.adult ?? this.adult,
      children: data.children ?? this.children,
      rooms: data.rooms ?? this.rooms);
}
