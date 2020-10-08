part of 'pages.dart';

class CreateRoom extends StatelessWidget {
  CreateRoom({Key key}) : super(key: key);
  final noController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final norController = TextEditingController();
  final descController = TextEditingController();
  GlobalKey<FlutterSummernoteState> _keyEditorDesc = GlobalKey();
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();

  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.bloc<CreateRoomBloc>().add(LoadDataCreate());
    File a;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: accentColor1,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  padding:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) {
                      if (userState is UserLoaded) {
                        if (imageFileToUpluad != null) {
                          uploadImage(imageFileToUpluad).then((downloadURL) {
                            imageFileToUpluad = null;
                            context
                                .bloc<UserBloc>()
                                .add(UpdateData(profileImage: downloadURL));
                          });
                        }
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToProfilePage());
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xFF5F5588), width: 1)),
                                child: Stack(
                                  children: [
                                    SpinKitCircle(
                                      color: accentColor2,
                                      size: 50,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: (userState.user
                                                          .profilePicture ==
                                                      ""
                                                  ? AssetImage(
                                                      "assets/user_pic.png")
                                                  : NetworkImage(userState
                                                      .user.profilePicture)),
                                              fit: BoxFit.cover)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin -
                                      78,
                                  child: Text(
                                    userState.user.name,
                                    style: whiteTextFont.copyWith(fontSize: 18),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Text(
                                  userState.user.email,
                                  style: yellowNumberFont.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        );
                      } else {
                        return SpinKitCircle(
                          color: accentColor2,
                          size: 50,
                        );
                      }
                    },
                  ),
                ),
                BlocListener<CreateRoomBloc, CreateRoomState>(
                  listener: (context, state) {
                    if (state is Error) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        message: state.error,
                      )..show(context);
                    }
                    else  if(state is CreateRoomSuccess ){
                              context.bloc<PageBloc>().add(GoToMainPage());

                    }
                  },
                  child: BlocBuilder<CreateRoomBloc, CreateRoomState>(
                      builder: (context, state) {
                    if (state is CreateRoomInitial) {
                      return Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 0.5,
                        backgroundColor: Colors.amber,
                      ));
                    }
                    print("state");
                    print(state);

                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Form(
                        // key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            MataramDropdown(
                              onChangedDropDown: (val) {
                                print(" value ku");
                                state.createRoomModel.typeValue = val;
                                context
                                    .bloc<CreateRoomBloc>()
                                    .add(OnChangeDropdown());
                              },
                              answers: state.createRoomModel.type.map((e) {
                                    return {
                                      "value": state.createRoomModel.type
                                          .indexOf(e)
                                          .toString(),
                                      "name": e == "" ? "Choose Children" : e
                                    };
                                  })?.toList() ??
                                  [],
                              valueDropdown: state?.createRoomModel?.typeValue,
                            ),
                            state.createRoomModel.image == null
                                ? Container()
                                : Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          1.4,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Image.asset(state
                                                      ?.createRoomModel
                                                      ?.image
                                                      ?.path ==
                                                  null
                                              ? ""
                                              : state
                                                  .createRoomModel.image.path)),
                                    ),
                                  ),
                            MataramTile(
                                title: Text("Thumbnail"),
                                subtitle: FlatButton(
                                    onPressed: () async {
                                      a = await getImage();
                                      print(a.path);
                                      state.createRoomModel.image = a;
                                      context
                                          .bloc<CreateRoomBloc>()
                                          .add(OnPickedImageCreate());
                                      return;
                                    },
                                    child: Container(
                                      child: Icon(Icons.image),
                                    ))),
                            Text("Picture"),
                            Container(
                                margin: EdgeInsets.fromLTRB(25, 10, 20, 12),
                                height:
                                    MediaQuery.of(context).size.height / 2.3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () async {
                                              a = await getImage();
                                              print(a.path);
                                              state.createRoomModel.picture1 =
                                                  a;
                                              context
                                                  .bloc<CreateRoomBloc>()
                                                  .add(OnPickedImageCreate());
                                            },
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: state.createRoomModel
                                                            .picture1 ==
                                                        null
                                                    ? Icon(Icons.add)
                                                    : Image.asset(state
                                                                .createRoomModel
                                                                .picture1 ==
                                                            null
                                                        ? ""
                                                        : state.createRoomModel
                                                            .picture1.path))),
                                        GestureDetector(
                                            onTap: () async {
                                              a = await getImage();
                                              print(a.path);
                                              state.createRoomModel.picture2 =
                                                  a;
                                              context
                                                  .bloc<CreateRoomBloc>()
                                                  .add(OnPickedImageCreate());
                                            },
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: state.createRoomModel
                                                            .picture2 ==
                                                        null
                                                    ? Icon(Icons.add)
                                                    : Image.asset(state
                                                                .createRoomModel
                                                                .picture2 ==
                                                            null
                                                        ? ""
                                                        : state.createRoomModel
                                                            .picture2.path))),
                                        GestureDetector(
                                            onTap: () async {
                                              a = await getImage();
                                              print(a.path);
                                              state.createRoomModel.picture3 =
                                                  a;
                                              context
                                                  .bloc<CreateRoomBloc>()
                                                  .add(OnPickedImageCreate());
                                            },
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: state.createRoomModel
                                                            .picture3 ==
                                                        null
                                                    ? Icon(Icons.add)
                                                    : Image.asset(state
                                                                .createRoomModel
                                                                .picture3 ==
                                                            null
                                                        ? ""
                                                        : state.createRoomModel
                                                            .picture3.path))),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        GestureDetector(
                                            onTap: () async {
                                              a = await getImage();
                                              print(a.path);
                                              state.createRoomModel.picture4 =
                                                  a;
                                              context
                                                  .bloc<CreateRoomBloc>()
                                                  .add(OnPickedImageCreate());
                                            },
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: state.createRoomModel
                                                            .picture4 ==
                                                        null
                                                    ? Icon(Icons.add)
                                                    : Image.asset(state
                                                                .createRoomModel
                                                                .picture4 ==
                                                            null
                                                        ? ""
                                                        : state.createRoomModel
                                                            .picture4.path))),
                                        GestureDetector(
                                            onTap: () async {
                                              a = await getImage();
                                              print(a.path);
                                              state.createRoomModel.picture5 =
                                                  a;
                                              context
                                                  .bloc<CreateRoomBloc>()
                                                  .add(OnPickedImageCreate());
                                            },
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: state.createRoomModel
                                                            .picture5 ==
                                                        null
                                                    ? Icon(Icons.add)
                                                    : Image.asset(state
                                                                .createRoomModel
                                                                .picture5 ==
                                                            null
                                                        ? ""
                                                        : state.createRoomModel
                                                            .picture5.path))),
                                        GestureDetector(
                                            onTap: () async {
                                              a = await getImage();
                                              print(a.path);
                                              state.createRoomModel.picture6 =
                                                  a;
                                              context
                                                  .bloc<CreateRoomBloc>()
                                                  .add(OnPickedImageCreate());
                                            },
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2.0,
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: state.createRoomModel
                                                            .picture6 ==
                                                        null
                                                    ? Icon(Icons.add)
                                                    : Image.asset(state
                                                                .createRoomModel
                                                                .picture6 ==
                                                            null
                                                        ? ""
                                                        : state.createRoomModel
                                                            .picture6.path))),
                                      ],
                                    ),
                                  ],
                                )),
                            MataramTile(
                              title: Text("No Room"),
                              subtitle: Container(
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: noController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      labelText: "No Room",
                                      hintText: "No Room",
                                    )),
                              ),
                            ),
                            MataramTile(
                              title: Text("Room Name"),
                              subtitle: Container(
                                child: TextField(
                                    // onChanged: (val) {
                                    //   state.createRoomModel.nameRoom = val;
                                    //   context
                                    //       .bloc<CreateRoomBloc>()
                                    //       .add(OnPickedImageCreate());
                                    // },
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      labelText: "Room Name",
                                      hintText: "Room Name",
                                    )),
                              ),
                            ),
                            Text("Description"),
                            Container(
                              //  margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.only(left: 10, top: 10),
                              alignment: Alignment.centerLeft,

                              child: FlutterSummernote(
                                height: MediaQuery.of(context).size.height / 3,
                                hint: "Your text here...",
                                key: _keyEditorDesc,
                                customToolbar: """
                                [
                                  ['style', ['bold', 'italic', 'underline', 'clear']],
                                  ['font', ['strikethrough', 'superscript', 'subscript']]
                                ]
                              """,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                            ),
                            MataramTile(
                              title: Text("Number Of Room"),
                              subtitle: Container(
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: norController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      labelText: "Number Of Room",
                                      hintText: "Number Of Room",
                                    )),
                              ),
                            ),
                            MataramTile(
                              title: Text("Price"),
                              subtitle: Container(
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: priceController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      labelText: "Price",
                                      hintText: "Price",
                                    )),
                              ),
                            ),
                            //    MataramTile(
                            //   title: Text("Description"),
                            //   subtitle: Container(
                            //     child: TextField(
                            //         // keyboardType: TextInputType.number,
                            //         controller: descController,
                            //         decoration: InputDecoration(
                            //           border: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(10)),
                            //           labelText: "Number Of Room",
                            //           hintText: "Number Of Room",
                            //         )),
                            //   ),
                            // ),
                            // MataramTile(
                            //   title: Text("Description"),
                            //   subtitle: Container(
                            //     child: TextField(
                            //       // maxLines: 3,
                            //         // keyboardType: TextInputType.number,
                            //         controller: descController,
                            //         decoration: InputDecoration(
                            //           border: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(10)),
                            //           labelText: "Description",
                            //           hintText: "Description",
                            //         )),
                            //   ),
                            // ),
                            Text("Facility"),
                            Container(
                              //  margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.only(left: 10, top: 10),
                              alignment: Alignment.centerLeft,

                              child: FlutterSummernote(
                                height: MediaQuery.of(context).size.height / 3,
                                hint: "Your text here...",
                                key: _keyEditor,
                                customToolbar: """
                                [
                                  ['style', ['bold', 'italic', 'underline', 'clear']],
                                  ['font', ['strikethrough', 'superscript', 'subscript']]
                                ]
                              """,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: MataramButton(
                                onPressed: () async {
                                  // print(priceController.text);
                                  // print("${int.parse(priceController.value.text)}");
                                  // print("${nameController.text}");

                                  if (nameController.text.isEmpty) {
                                    Flushbar(
                                      duration: Duration(milliseconds: 1500),
                                      flushbarPosition: FlushbarPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      message: 'Room Name is Empty',
                                    )..show(context);
                                  } else if (priceController.text.isEmpty) {
                                    Flushbar(
                                      duration: Duration(milliseconds: 1500),
                                      flushbarPosition: FlushbarPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      message: 'Room Price is Empty',
                                    )..show(context);
                                  } else if (_keyEditor.currentState
                                          .getText() ==
                                      null) {
                                    Flushbar(
                                      duration: Duration(milliseconds: 1500),
                                      flushbarPosition: FlushbarPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      message: 'Room Description is Empty',
                                    )..show(context);
                                  }
                                  // else if (_keyEditorDesc == null) {
                                  //   Flushbar(
                                  //     duration: Duration(milliseconds: 1500),
                                  //     flushbarPosition: FlushbarPosition.BOTTOM,
                                  //     backgroundColor: Colors.red,
                                  //     message: 'Room Facility is Empty',
                                  //   )..show(context);
                                  // }
                                  else {
                                    var a =
                                        await _keyEditor.currentState.getText();
                                    state.createRoomModel.facility = a;
                                    var b = await _keyEditorDesc.currentState
                                        .getText();
                                    state.createRoomModel.desc = b;
                                    context.bloc<CreateRoomBloc>().add(AddRoom(
                                          edit: false,
                                          price:
                                              int.parse(priceController.text),
                                          roomNamme: nameController.text,
                                          noFRoom: int.parse(norController.text),
                                          noRoom:int.parse( noController.text)
                                          // description: descController.text,
                                        ));
                                  }

                                  // return;
                                },
                                title: Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: 'edit',
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                )
              ])),
        ),
      ),
    );
  }
}
