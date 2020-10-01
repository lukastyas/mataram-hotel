part of 'pages.dart';

class RoomDetail extends StatelessWidget {
  final RoomModel room;
  const RoomDetail({Key key, this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FacilitiesModel> facilities = [
      FacilitiesModel(
        id: 1,
        title: 'Free Wifi',
        icon: Icon(Icons.wifi),
      ),
      FacilitiesModel(
        id: 2,
        title: 'Satelite Television',
        icon: Icon(Icons.wifi),
      ),
      FacilitiesModel(
        id: 3,
        title: 'Mineral Water',
        icon: Icon(Icons.wifi),
      ),
      FacilitiesModel(
        id: 4,
        title: 'Clean Linen',
        icon: Icon(Icons.wifi),
      ),
      FacilitiesModel(
        id: 5,
        title: 'Clean Washroom',
        icon: Icon(Icons.wifi),
      ),
      FacilitiesModel(
        id: 6,
        title: 'Toiletries',
        icon: Icon(Icons.wifi),
      ),
    ];

    // List<FacilitiesModel> listIcon = List();
    // room.data.forEach((el) {
    //   // final duplicateItems = getMenuss();

    //   facilities.forEach((e) {
    //     if (el == e.id) {
    //       print("e.id");
    //       print(e.id);
    //       listIcon.add(e);
    //     }
    //   });
    // });

    // print("listIcon.toList()");
    // print(listIcon.toList());

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSearchRoomPage(room.type));

        return;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: PageView.builder(
                      onPageChanged: (int index) {
                        print(index);
                        // setState(() {
                        //   _currentPageNotifier.value = index;
                        // });
                      },
                      itemCount: room.photos.length,
                      itemBuilder: (context, index) {
                        // return Text(state.announcementModel.data.data[index].description);
                        return ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          child:
                              // Image.asset("assets/images/no_image.png")

                              ///save dulu nanti edit lagi
                              FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            placeholder: 'assets/no_image.png',
                            image: room.photos[index].url,
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(room.roomName),
                ),
               room.rate == null ? Container():  Padding(
                  padding: const EdgeInsets.only(left: 130.0),
                  child: RatingStars(
                    voteAverage:double.parse( room.rate),
                    color: Colors.amber,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Facilities Room"),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 110.0),
                    //   child: Row(
                    //     children: listIcon.map((e) {
                    //       return ContentTile(e.icon, e.title);
                    //     }).toList(),
                    //   ),
                    // )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      title: Text("Description Room"),
                      subtitle:HtmlWidget(
                        room.description?? ""
                      )
                      
                      //  Text(
                      //   room.description?? "",
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //   ),
                      //   textAlign: TextAlign.justify,
                      // )
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      title: Text("Facility"),
                      subtitle:HtmlWidget(
                        room.facility?? ""
                      )
                      
                      //  Text(
                      //   room.description?? "",
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //   ),
                      //   textAlign: TextAlign.justify,
                      // )
                      ),
                ),
                MataramButton(
                  onPressed: () {
                    context.bloc<PageBloc>().add(GotoBookDetail(room));
                    return;
                  },
                  title: Text(
                    "Countinue to Book",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: 'edit',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
