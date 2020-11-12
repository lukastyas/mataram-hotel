import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
      yield SearchRoomInitial(dataSearch: DataSearch());
      var books = await BookService.getBook();

      var room = await RoomServices.getRoom();

      List<RoomModel> roomModel = [];

      String statusCheckin;
      String type;
      print("event.typeRsssssssssssssoom");
      print(event.typeRoom);

      // if (event.admin == false) {
      //   room.forEach((element) {
      //     if (element.type == event.typeRoom.toString()) {
      //       roomModel.add(element);
      //     }
      //   });
      // } else {
      // book.map((e) => print("e.checkIn ${e.checkIn}")).toList();
      books.map((e) {
        statusCheckin = e.statuscheckIn;
        type = e.type;
      }).toList();

      room.map((element) {
        print("element.typesss");
        print(event.typeRoom.toString() == element.type);
        if (event.typeRoom == 1) {
          print("element");
          print(element.type);
          if (element.type == "1") {
            roomModel.add(element);
          }
        } else if (event.admin == true) {
          print("element.admin");
          print(element.type);
          roomModel.add(element);
          // }
        } else {
          if (element.type == "0") {
            roomModel.add(element);
          }
        }
      }).toList();
      // }

      yield RoomLoaded(
          dataSearch: DataSearch(
              room: roomModel,
              book: books,
              statusCheckin: statusCheckin,
              type: type));
    } else if (event is OnChangeDate) {
      DataSearch data = state.dataSearch;
      print("data.selecetedDateFrom");
      print(data.selecetedDateFrom);
      print(data.selecetedDateFrom);
      print(data.adult);
      print(data.children);
      print(data.rooms);
      yield RoomLoaded(dataSearch: data.copyWith(data));
    } else if (event is DeletedRoom) {
      yield SearchRoomInitial(dataSearch: DataSearch());

      print(event.idOrder);
      await RoomServices.deletedRoom(id: event.idOrder);
      var room = await RoomServices.getRoom();
      List<RoomModel> roomModel = [];
      print("event.typeRoom");

      // if (event.admin == false) {
      //   room.forEach((element) {
      //     if (element.type == event.typeRoom.toString()) {
      //       roomModel.add(element);
      //     }
      //   });
      // } else {

      room.map((element) {
        print("element.typesss");
        roomModel.add(element);
      }).toList();
      // }

      yield RoomLoaded(dataSearch: DataSearch(room: roomModel));
    }
  }
}
