part of 'services.dart';

class BookService {
  static CollectionReference _bookCollection =
      Firestore.instance.collection("booking");
  static CollectionReference roomCollection =
      Firestore.instance.collection("hotelRoom");

  static Future<void> createRoom(BookModels bookModel) async {
    await _bookCollection.document(bookModel.idOrder).setData({
      'id_order': bookModel.idOrder,
      'id_user': bookModel.idUser,
      'id_room': bookModel.idRoom,
      'check_in': bookModel.checkIn,
      'check_out': bookModel.checkOut,
      'room_name': bookModel.roomName,
      'thumbnail':bookModel.thumbnail,
      'total_night': bookModel.totalNight,
      'room':bookModel.room,

      // 'time_stamp': firebase.database.ServerValue.TIMESTAMP ,

      'evidence': "",
      'price': bookModel.price,
    });
    // print(snapshot);
  }

  static Future<void> updateUser(BookModels user) async {
    _bookCollection.document(user.idOrder).updateData({
      'evidence': user.evidence,
    });
  }
  static Future<void> updateRate(RoomModel user, idRoom) async {
    print(user.rate);
    print(user.review);
    print(idRoom);
    roomCollection.document(idRoom).updateData({
      'rate': user.rate,
      "review" :user.review
    });
  }
  static Future<void> approve(BookModels user) async {
    _bookCollection.document(user.idOrder).updateData({
      'status': user.status,
    });
  }


  static Future<List<BookModels>> getBook() async {
  
    QuerySnapshot snapshot = await _bookCollection.getDocuments();

    List<BookModels> room = snapshot.documents
        .map((e) => BookModels(
          thumbnail: e.data['thumbnail'],
          room: e.data['room'],
          totalNight: e.data['total_night'],
          roomName: e.data['room_name'],
            checkIn: e.data['check_in'],
            checkOut: e.data['check_out'],
            idOrder: e.data['id_order'],
            idUser: e.data['id_user'],
            idRoom: e.data['id_room'],
            price: e.data['price'],
            status: e.data['status'],
            evidence: e.data['evidence']))
        .toList();
    return room;
  }
}