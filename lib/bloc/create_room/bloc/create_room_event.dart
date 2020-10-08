part of 'create_room_bloc.dart';

@immutable
abstract class CreateRoomEvent {}

class LoadDataCreate extends CreateRoomEvent {}

class OnChangeDropdown extends CreateRoomEvent {}

class OnPickedImageCreate extends CreateRoomEvent {}

class AddRoom extends CreateRoomEvent {
  final id;
  final String description;
  final int price;
  final int noRoom;
  final int noFRoom;
  final String roomNamme;
  final String capacity;
  final String picture;
  final String photo1;
  final String photo2;
  final String photo3;
  final String photo4;
  final String photo5;
  final String photo6;
  final edit;
  final type;
  final String duration;

  AddRoom(
      {this.picture,
      this.photo1,
      this.photo2,
      this.photo3,
      this.photo4,
      this.photo5,
      this.photo6,
      this.id,
      this.type,
      this.noRoom,
      this.edit,
      this.capacity,
      this.duration,
      this.noFRoom,
      this.description,
      this.price,
      this.roomNamme});
}
