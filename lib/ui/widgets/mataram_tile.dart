part of 'widgets.dart';

class MataramTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;

  const MataramTile({Key key, this.title, this.subtitle,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:5.0, bottom:5.0),
      child: Row(children: <Widget>[
        Expanded(
          child: title),
        Expanded(child:subtitle)
      ],),
    );
  }
}