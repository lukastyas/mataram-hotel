part of 'services.dart';

class CreateRoomService{
    static CollectionReference _userCollection =
      Firestore.instance.collection('hotelRoom');
//* Service untuk membuat ruangan
        static Future<void> createRoom(RoomModel room) async {
    _userCollection.document(room.id).setData({
      'id_room': room.id,
      'description': room.description,
      'picture': room.picture,
      'price': room.price,
      'rate': "8.0",
      'type': room.type ,
      'room_book':0,
      'roomName': room.roomName ,
      'capacity': room.capacity ,
      'facilities': room.data ,
      'duration':room.duration,
      'photos': room.photos ,
      'no_room': room.noRoom ,
      'no_of_room': room.noFRoom ,
    });
  }

  //* Service untuk Edit atau update ruangan

        static Future<void> updateRoom(RoomModel room) async {
    _userCollection.document(room.id).updateData({
      'id_room': room.id,
      'description': room.description,
      'picture': room.picture,
      'price': room.price,
      'rate': "8.0",
      'type': room.type ,
      'roomName': room.roomName ,
      'capacity': room.capacity ,
      'facilities': room.data ,
      'duration':room.duration,
      'photos': room.photos ,
      'no_room': room.noRoom ,
      'no_of_room': room.noFRoom ,
    });
  }

  //* service untuk mengurangi jumlah booking jika ingin checkout
        static Future<void> updateRoomBook(idRoom, roomBook) async {
    _userCollection.document(idRoom).updateData({
      'room_book': roomBook,
    });
  }
}