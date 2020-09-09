part of 'create_room_bloc.dart';

@immutable
abstract class CreateRoomEvent {}

class LoadDataCreate extends CreateRoomEvent{}
class OnChangeDropdown extends CreateRoomEvent{}
class OnPickedImageCreate extends CreateRoomEvent{}
class AddRoom extends CreateRoomEvent{
 final String description;
  final int price;
  final int noRoom;
  final int noFRoom;
  final String roomNamme;


  AddRoom({this.noRoom, this.noFRoom, this.description, this.price, this.roomNamme});
}
