part of 'models.dart';

class BookModels {
  final String idOrder;
  final String idUser;
  final String idRoom;
  final String checkIn;
  final String statuscheckIn;
  final String checkOut;
  final String evidence;
  final int price;
  final String roomName;
  final String thumbnail;
  final String totalNight;
  final String type;
  final String room;
  final String status;
  final double rate;
  final String review;
  final int noofRoom;
  final int roomBook;
  final String startEvent;

  BookModels({this.totalNight, this.room, 
      this.idOrder,
      this.review,
      this.type,
      this.roomBook,
      this.status,
      this.rate,
      this.statuscheckIn,
      this.idUser,
      this.noofRoom,
      this.idRoom,
      this.roomName,
      this.thumbnail,
      this.checkIn,
      this.checkOut,
      this.evidence,
      this.startEvent,
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
        type: json["type"],
        roomBook: json["room_book"],
        idOrder: json["id_order"],
        idUser: json["id_user"],
        idRoom: json["id_room"],
        statuscheckIn: json["status_check_in"],
        price: json["price"],
        checkIn: json["check_in"],
        evidence: json["evidence"],
        startEvent: json["start_event"],
        noofRoom: json["no_of_room"],
      );
}
