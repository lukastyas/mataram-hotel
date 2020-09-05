part of 'services.dart';

class RoomServices {
  static CollectionReference _roomCollection =
      Firestore.instance.collection("hotelRoom");

  static Future<List<RoomModel>> getRoom() async {
    QuerySnapshot snapshot = await _roomCollection.getDocuments();
    List<RoomModel> room =
        snapshot.documents.map((e) => RoomModel.fromJson(e.data)).toList();
    return room;
  }
}
