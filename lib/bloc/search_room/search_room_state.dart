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
  final List<RoomModel> room;


  DataSearch({this.room, this.selecetedDateFrom,  this.selecetedDateTo});

  DataSearch copyWith(DataSearch data) => DataSearch(
        room: data.room ?? this.room,
        selecetedDateFrom: data.selecetedDateFrom ?? this.selecetedDateFrom,
        selecetedDateTo: data.selecetedDateTo ?? this.selecetedDateTo,
      );
}
