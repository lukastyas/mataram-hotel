part of 'pages.dart';

class EditProfile extends StatelessWidget {
  final RoomModel room;
   EditProfile({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(room.picture),
    );
  }
}