part of 'create_room_bloc.dart';

@immutable
abstract class CreateRoomState {
  final CreateRoomModels createRoomModel;

  CreateRoomState(this.createRoomModel);
}

class CreateRoomInitial extends CreateRoomState {
  final CreateRoomModels createRoomModel;

  CreateRoomInitial({this.createRoomModel}) : super(createRoomModel);
}

class CreateRoomData extends CreateRoomState {
  final CreateRoomModels createRoomModel;

  CreateRoomData(this.createRoomModel) : super(createRoomModel);
}
class Error extends CreateRoomState {
  final CreateRoomModels createRoomModel;
  final String error;

  Error(this.createRoomModel, this.error) : super(createRoomModel);
}
class CreateRoomSuccess extends CreateRoomState {
  CreateRoomSuccess({CreateRoomModels createRoomModel}) : super(createRoomModel);
}

class CreateRoomModels {
  List<String> type;
  String facility;
  File picture1;
  File picture2;
  File picture3;
  File picture4;
  File picture5;
  File picture6;
  String typeValue;
  String noRoom;
  String nameRoom;
  String nofRoom;
  String price;
  String desc;
  File image;

  CreateRoomModels({
    this.facility,
    this.picture1,
    this.picture2,
    this.picture3,
    this.picture4,
    this.picture5,
    this.picture6,
    this.desc,
    this.price,
    this.type, this.typeValue, this.image});

  CreateRoomModels copyWith(CreateRoomModels data) => CreateRoomModels(
      type: data.type ?? this.type,
      desc: data.desc ?? this.desc,
      price: data.price ?? this.price,
      picture1: data.picture1 ?? this.picture1,
      picture2: data.picture2 ?? this.picture2,
      picture3: data.picture3 ?? this.picture3,
      picture4: data.picture4 ?? this.picture4,
      picture5: data.picture5 ?? this.picture5,
      picture6: data.picture6 ?? this.picture6,
      typeValue: data.typeValue ?? this.typeValue,
      facility: data.facility ?? this.facility,
      image: data.image ?? this.image);
}

class Facilities{
  String facility;
  bool selected;

  Facilities({this.facility, this.selected = false});
}
