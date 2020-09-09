part of 'pages.dart';

class SendEvidencePage extends StatelessWidget {
      final RoomModel room;

  const SendEvidencePage({
    Key key, this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File a;
    return WillPopScope(onWillPop: () async {
      context.bloc<PageBloc>().add(GotoTransferPage(roomModel: room));
      return;
    }, child: Scaffold(
      body: BlocBuilder<SendEvidenceBloc, SendEvidenceState>(
          builder: (context, state) {
        print(state.sendEvidence.image);
        return Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: MediaQuery.of(context).size.height / 3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.asset(
                          state?.sendEvidence?.image?.path == null
                              ? ""
                              : state.sendEvidence.image.path)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.photo_camera),
                      onPressed: () async {
                        a = await getImageFromCamera();
                        print(a.path);
                        state.sendEvidence.image = a;
                        context.bloc<SendEvidenceBloc>().add(OnPickedImage());
                        return;
                      }),
                  IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () async {
                        a = await getImage();
                        print(a.path);
                        state.sendEvidence.image = a;
                        context.bloc<SendEvidenceBloc>().add(OnPickedImage());
                        return;
                      })
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 200),
                child: MataramButton(
                  onPressed: () {},
                  title: Text(
                    "Send",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: 'edit',
                ),
              )
            ],
          ),
        );
      }),
    ));
  }
}
