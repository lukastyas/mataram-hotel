part of 'widgets.dart';

class MataramButton extends StatelessWidget {
  final Widget title;
  final String color;
  @required
  final VoidCallback onPressed;

  MataramButton({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        color:  
            Color(0xff3E4295),
        child: title,
        onPressed: onPressed);
  }
}
