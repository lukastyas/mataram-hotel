part of 'models.dart';

class BookModels {
  final String idOrder;
  final String idUser;
  final String idRoom;
  final String checkIn;
  final String checkOut;
  final String evidence;
  final int price;
  final String roomName;
  final String thumbnail;
  final String totalNight;
  final String room;
  final String status;

  BookModels({this.totalNight, this.room, 
      this.idOrder,
      this.status,
      this.idUser,
      this.idRoom,
      this.roomName,
      this.thumbnail,
      this.checkIn,
      this.checkOut,
      this.evidence,
      this.price});

  factory BookModels.fromJson(
    Map<String, dynamic> json,
  ) =>
      BookModels(
        totalNight: json['total_night'],
        status: json['status'],
        room: json['room'],
        thumbnail: json['thumbnail'],
        roomName: json['roomName'],
        checkOut: json["check_out"],
        idOrder: json["id_order"],
        idUser: json["id_user"],
        idRoom: json["id_room"],
        price: json["price"],
        checkIn: json["check_in"],
        evidence: json["evidence"],
      );
}
