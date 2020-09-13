import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mataram2/models/models.dart';
import 'package:mataram2/services/services.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'search_room_event.dart';
part 'search_room_state.dart';

class SearchRoomBloc extends Bloc<SearchRoomEvent, SearchRoomState> {
  @override
  SearchRoomState get initialState =>
      SearchRoomInitial(dataSearch: DataSearch());

  @override
  Stream<SearchRoomState> mapEventToState(
    SearchRoomEvent event,
  ) async* {
    if (event is LoadRoom) {
      var room = await RoomServices.getRoom();
      List<RoomModel> roomModel = [];
      print("event.admin");
      print(event.admin);
      if (event.admin == false) {
        room.forEach((element) {
          if (element.type == event.typeRoom.toString()) {
            roomModel.add(element);
          }
        });
      } else {
        room.forEach((element) {
          roomModel.add(element);
        });
      }

      yield RoomLoaded(dataSearch: DataSearch(room: roomModel));
    } else if (event is OnChangeDate) {
      DataSearch data = state.dataSearch;
      print("data.selecetedDateFrom");
      print(data.selecetedDateFrom);
      print(data.selecetedDateFrom);
      print(data.adult);
      print(data.children);
      print(data.rooms);
      yield RoomLoaded(dataSearch: data.copyWith(data));
    }
  }
}
