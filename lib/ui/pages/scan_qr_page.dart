part of 'pages.dart';

class ScanQRPage extends StatefulWidget {
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR(test) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
      if (test == 1) {
        context.bloc<SendEvidenceBloc>().add(SendCheckIn(barcodeScanRes));
      } else if (test == 2) {
        context.bloc<SendEvidenceBloc>().add(SendCheckOut(barcodeScanRes));
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Scan QR Code'),
          backgroundColor: accentColor1,
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Scan result : $_scanBarcode\n',
                      style: TextStyle(fontSize: 20)),
                  BlocListener<SendEvidenceBloc, SendEvidenceState>(
                    listener: (context, state) {
                      if (state is Errors) {
                        Flushbar(
                          duration: Duration(milliseconds: 1500),
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          message: state.message,
                        )..show(context);
                      }
                    },
                    child: BlocBuilder<SendEvidenceBloc, SendEvidenceState>(
                        builder: (BuildContext context, state) {
                      if (state is ScanResult) {
                        return Text(state.statuCheckin == "1"
                            ? "Check-in"
                            : state.statuCheckin == "2"
                                ? "Check Out"
                                : "No Check-in");
                      }
                      return Container();
                    }),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MataramButton(
                          onPressed: () => scanQR(1),
                          title: Text(
                            "Check In",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: 'edit',
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        MataramButton(
                          onPressed: () => scanQR(2),
                          title: Text(
                            "Check Out",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: 'edit',
                        ),
                      ],
                    ),
                  )
                ])));
  }
}
