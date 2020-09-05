part of 'widgets.dart';

class ContentTile extends StatelessWidget {
  final Widget widget;
  final subtitle;
  const ContentTile(this.widget, this.subtitle, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.pink[100]),
              child: widget),
          Container(
            width: 60,
            height: 40.0,
            alignment: Alignment.center,
            // padding: const EdgeInsets.all(10.0),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.3,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
