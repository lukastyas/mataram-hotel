part of 'models.dart';

class RoomModel extends Equatable {
  final String description;
  final String picture;
  final int price;
  final String roomName;
  final int rate;
  final List<int> data;
  final List<Photo> photos;

  RoomModel(
      {this.photos,
      this.description,
      this.data,
      this.picture,
      this.price,
      this.roomName,
      this.rate});

  RoomModel copyWith({String picture, String price, String roomName}) =>
      RoomModel(
          description: this.description,
          picture: picture ?? this.picture,
          price: price ?? this.price,
          rate: rate ?? this.rate,
          roomName: roomName ?? this.roomName,
          data: data ?? this.data,
          photos: photos ?? this.photos);

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        description: json["description"],
        picture: json["picture"],
        price: json["price"],
        rate: json["rate"],
        roomName: json["roomName"],
        data: List<int>.from(json["facilities"].map((x) => x)),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

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
