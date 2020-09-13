part of 'services.dart';

class RoomServices {
  static CollectionReference _roomCollection =
      Firestore.instance.collection("hotelRoom");

  static Future<List<RoomModel>> getRoom({id}) async {
    QuerySnapshot snapshot = await _roomCollection. getDocuments();
    print("snapshot.documents[0].documentID");
    print(snapshot.documents[0].data,);
    List<RoomModel> room =
        snapshot.documents.map((e) => RoomModel.fromJson(e.data, e.documentID)).toList();
    return room;
  }
}
