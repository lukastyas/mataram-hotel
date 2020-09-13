part of 'services.dart';

class CreateRoomService{
    static CollectionReference _userCollection =
      Firestore.instance.collection('hotelRoom');

        static Future<void> createRoom(RoomModel room) async {
    _userCollection.document(room.id).setData({
      'id_room': room.id,
      'description': room.description,
      'picture': room.picture,
      'price': room.price,
      'rate': room.rate,
      'type': room.type ,
      'roomName': room.roomName ,
      'facilities': room.data ,
      'photos': room.photos ,
      'no_room': room.noRoom ,
      'no_of_room': room.noFRoom ,
    });
  }
}