part of 'models.dart';

class RoomModel extends Equatable {
  final String id;
  final String description;
  final String picture;
  final int price;
  final String roomName;
  final String type;
  final double rate;
  final int noFRoom;
  final int noRoom;
  final String data;
  final String review;
  final List<dynamic> photos;

  RoomModel({this.noFRoom, this.noRoom, 
     this.review,
        this.id,
        this.type,
        this.photos,
      this.description,
      this.data,
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
        rate: json["rate"],
        type: json["type"],
        noFRoom: json["no_of_roomm"],
        roomName: json["roomName"],
        data:json["facilities"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

 Map<String, dynamic> toJson() => {
        "description": description,
        "picture": picture,
        "price": price,
        "rate": rate,
        "type": type,
        "no_of_roomm": noFRoom,
        "roomName": roomName,
        "facilities": data,
       
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
