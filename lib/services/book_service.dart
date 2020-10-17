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
      'thumbnail': bookModel.thumbnail,
      'start_event': bookModel.startEvent,
      'total_night': bookModel.totalNight,
      'room': bookModel.room,
      'status': "1",
      'type':bookModel.type,
      'create_date':DateTime.now(),
      'status_check_in':"0",

      // 'time_stamp': firebase.database.ServerValue.TIMESTAMP ,

      'evidence': "",
      'price': bookModel.price,
    });
    // print(snapshot);
  }

 static Future<void> updateNofRoom(BookModels user) async {
    roomCollection.document(user.idRoom).updateData({
      'no_of_room': user.noofRoom,
    });
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
    roomCollection
        .document(idRoom)
        .updateData({'rate': user.rate, "review": user.review});
  }

  static Future<void> approve(BookModels user) async {
    _bookCollection.document(user.idOrder).updateData({
      'status': user.status,
    });
  }

  static Future<void> checkIn(BookModels user) async {
    _bookCollection
        .document(user.idOrder)
        .updateData({'check_in': user.checkIn, 'status_check_in': "1"});
  }

  static Future<void> checkOut(BookModels user) async {
    _bookCollection
        .document(user.idOrder)
        .updateData({'check_out': user.checkOut, 'status_check_in': "2"});
  }

  static Future<List<BookModels>> getBook() async {
    QuerySnapshot snapshot = await _bookCollection.getDocuments();

    List<BookModels> room = snapshot.documents
        .map((e) {
        
        return  BookModels(
            thumbnail: e.data['thumbnail'],
            room: e.data['room'],
            totalNight: e.data['total_night'],
            roomName: e.data['room_name'],
            checkIn: e.data['check_in'],
            checkOut: e.data['check_out'],
            idOrder: e.data['id_order'],
            idUser: e.data['id_user'],
            idRoom: e.data['id_room'],
            type: e.data['type'],
            startEvent: e.data['start_event'],
            price: e.data['price'],
            status: e.data['status'],
            statuscheckIn: e.data['status_check_in'],
            evidence: e.data['evidence']);

            }
            )
        .toList();
    return room;
  }
}
