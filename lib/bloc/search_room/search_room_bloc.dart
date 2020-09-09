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
      print("ini ini");
      print(event.typeRoom);
      room.forEach((element) {
        print(element.type);
        print(element.type == event.typeRoom.toString());
        if (element.type == event.typeRoom.toString()) {
          print("ninin");
          roomModel.add(element);
        } 
      });
      print("fnwifnwiwf");
      print(roomModel[0].roomName);
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
