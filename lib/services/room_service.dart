part of 'services.dart';

class RoomServices {
  static CollectionReference _roomCollection =
      Firestore.instance.collection("hotelRoom");

  static Future<List<RoomModel>> getRoom({id}) async {
    QuerySnapshot snapshot = await _roomCollection. getDocuments();
    List<RoomModel> room =
        snapshot.documents.map((e) => RoomModel.fromJson(e.data, e.documentID)).toList();
    return room;
  }
  static Future<void> deletedRoom({id}) async {
    await _roomCollection.document(id).delete();
  
  }
}
