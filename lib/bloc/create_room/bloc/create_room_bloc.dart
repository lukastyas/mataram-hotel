import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mataram2/models/models.dart';
import 'package:mataram2/services/services.dart';
import 'package:mataram2/shared/shared.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  @override
  Stream<CreateRoomState> mapEventToState(
    CreateRoomEvent event,
  ) async* {
    if (event is LoadDataCreate) {
      CreateRoomModels data = state.createRoomModel;
      final List<String> type = [
        'Hotel Room',
        'Meeting Room',
      ];
      // final List<Facilities> facility = [
      //   Facilities(facility: "Free Wifi"),
      //   Facilities(facility: "Satelite Television"),
      //   Facilities(facility: 'Mineral Water'),
      //   Facilities(facility: 'Clean Linen'),
      //   Facilities(facility: 'Clean Washroom'),
      //   Facilities(facility: 'Toiletries'),
      // ];
      yield CreateRoomData(data.copyWith(CreateRoomModels(
        type: type,
      )));
    } else if (event is OnChangeDropdown) {
      CreateRoomModels data = state.createRoomModel;
      yield CreateRoomData(data.copyWith(data));
    } else if (event is OnPickedImageCreate) {
      CreateRoomModels data = state.createRoomModel;
      yield CreateRoomData(data.copyWith(data));
    } else if (event is AddRoom) {
      CreateRoomModels data = state.createRoomModel;
      yield CreateRoomInitial(createRoomModel: data.copyWith(data));

      print("====data.price====");
      print(data.facility);
      print(data.image);
      print(data.picture1);
      print(data.picture2);
      print(data.picture3);
      print(data.picture4);
      print(data.picture5);
      print(data.picture6);
      // print(data.facility);
      // print(data.facility);
      String thumbnail;
      String picture1;
      String picture2;
      String picture3;
      String picture4;
      String picture5;
      String picture6;
      thumbnail = data.image == null ? "" : await uploadImage(data.image);
      picture1 = data.picture1 == null ? "" : await uploadImage(data.picture1);
      picture2 = data.picture2 == null ? "" : await uploadImage(data.picture2);
      picture3 = data.picture3 == null ? "" : await uploadImage(data.picture3);
      picture4 = data.picture4 == null ? "" : await uploadImage(data.picture4);
      picture5 = data.picture5 == null ? "" : await uploadImage(data.picture5);
      picture6 = data.picture6 == null ? "" : await uploadImage(data.picture6);

      var picture = [
        picture1,
        picture2,
        picture3,
        picture4,
        picture5,
        picture6
      ];
      var uuid = Uuid();
      var v4crypto = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});

      print(picture1);
      print(picture2);
      print(picture3);
      print(picture4);
      print(picture5);
      print(picture6);
      var photoss;
      photoss = List<dynamic>.from(picture.map((e) {
        return {"id ": picture.indexOf(e), "url": e};
      })).toList();

// // print(map.toList());
//       state.createRoomModel.facility.where((e) => e.selected).map((e) {
//         facility.add(state.createRoomModel.facility.indexOf(e));
//       }).toList();

      RoomModel dataRoom = RoomModel(
          id: v4crypto,
          price: event.price,
          description: data.desc,
          roomName: event.roomNamme,
          photos: photoss,
          type: data.typeValue,
          data: data.facility,
          capacity: event.capacity,
          noFRoom: event.noFRoom,
          noRoom: event.noRoom,
          picture: thumbnail);

// // // print()

      var datas = CreateRoomService.createRoom(dataRoom);
      print("a");
      print(datas);
      yield CreateRoomSuccess(createRoomModel: data.copyWith(data));
      // if (data.typeValue == null) {
      //   yield Error(data.copyWith(data), 'Room Type is Empty');
      // } else if (data.image == null) {
      //   yield Error(data.copyWith(data), 'Thumbnail is Empty');
      // } else {

      // }
// else if(event.roomNamme ==null){
//   yield Error(data.copyWith(data), 'Room Name is Empty');
// }
// else if(data.desc ==null){
//   yield Error(data.copyWith(data), 'Room Description is Empty');
// }
// else if(data.price ==null){
//   yield Error(data.copyWith(data), 'Room Price is Empty');
// }
// else if(data.facility ==null){
//   yield Error(data.copyWith(data), 'Room Facility is Empty');
// }

    }
  }

  @override
  CreateRoomState get initialState =>
      CreateRoomInitial(createRoomModel: CreateRoomModels());
}
