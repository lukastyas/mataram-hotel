part of 'models.dart';

class RoomModel extends Equatable {
  final String id;
  final String description;
  final String facility;
  final String picture;
  final int price;
  final String roomName;
  final String type;
  final String rate;
  final int noFRoom;
  final int noRoom;
  final String data;
  final String review;
  final String capacity;
  final String duration;
  final List<dynamic> photos;

  RoomModel({this.noFRoom, this.noRoom, 
     this.review,
        this.id,
        this.type,
        this.photos,
        this.facility,
        this.capacity,
      this.description,
      this.data,
      this.duration,
      this.picture,
      this.price,
      this.roomName,
      this.rate});

  RoomModel copyWith({String picture, String price, String roomName}) =>
      RoomModel(
          id: this.id,
          description: this.description,
          picture: picture ?? this.picture,
          noFRoom: noFRoom ?? this.noFRoom,
          duration: duration ?? this.duration,
          facility: facility ?? this.facility,
          capacity: capacity ?? this.capacity,
          noRoom: noRoom ?? this.noRoom,
          type: type ?? this.type,
          price: price ?? this.price,
          rate: rate ?? this.rate,
          roomName: roomName ?? this.roomName,
          data: data ?? this.data,
          photos: photos ?? this.photos);

  factory RoomModel.fromJson(Map<String, dynamic> json, b) => RoomModel(
        id: b,
        description: json["description"],
        picture: json["picture"],
        price: json["price"],
        capacity: json["capacity"],
        rate: json["rate"],
        duration: json["duration"],
        facility: json["facilities"],
        type: json["type"],
        noFRoom: json["no_of_room"],
        noRoom: json["no_room"],
        roomName: json["roomName"],
        data:json["facilities"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

 Map<String, dynamic> toJson() => {
        "description": description,
        "picture": picture,
        "facilities": facility,
        "price": price,
        "capacity": capacity,
        "rate": rate,
        "type": type,
        "no_of_roomm": noFRoom,
        "roomName": roomName,
        "duration": duration,
       
      };
 
  @override
  String toString() {
    return " - $picture, $description";
  }

  @override
  List<Object> get props => [description, picture, price, roomName];
}

class Photo {
  Photo({
    this.id,
    this.url,
  });

  int id;
  String url;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
