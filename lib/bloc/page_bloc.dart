import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mataram2/models/models.dart';
import 'package:mataram2/services/services.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => OnInitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToMainPageUser) {
      var book = await BookService.getBook();
      print("book.length");
      print(book.length);
      yield OnNewestPage(book);
      // yield OnMainPageUser();
    } else if (event is GoToRegistrationPage) {
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccountConfirmationPage(event.registrationData);
    } else if (event is GoToProfilePage) {
      yield OnProfilePage();
    } else if (event is GotoNewest) {
      yield OnNewestPageGlobal();
    } else if (event is GoToEditProfilePage) {
      yield OnEditProfilePage(event.user);
    } else if (event is GotoScanPage) {
      yield OnScanPage(event.pageEvent);
    } else if (event is GoToMyBookingPage) {
      var book = await BookService.getBook();
      var roomS = await RoomServices.getRoom();
      List<RoomModel> roomModel = [];

      roomS.map((e) {
        roomModel.add(e);
      }).toList();

      yield OnMyBookingPage(event.pageEvent, book, roomModel, event.role);
    } else if (event is GoToSearchRoomPage) {
      yield OnSearchRoomPage(event.typeRoom);
    } else if (event is GotoDetailRoom) {
      yield OnRoomDetailPage(event.roomModel);
    } else if (event is GotoBookDetail) {
      List<BookModels> bookModels = [];
      // book.forEach((element) {
      //   bookModels.add(element);
      // });

      yield OnBookDetailPage(event.roomModel, bookModels);
    } else if (event is GotoTransferPage) {
      print("event.roomModel.roomName");
      print(event.roomModel.id);
      print(event.selecetedDateFrom);
      print(event.selecetedDateTo);
      print(event.uid);

      if (!event.back) {
        await BookService.createRoom(BookModels(
            roomName: event.roomModel.roomName,
            thumbnail: event.roomModel.picture,
            idOrder: event.idOrder,
            statuscheckIn: "",
            type: event.roomModel.type,
            idUser: event.uid,
            startEvent: event.startEvent.toString(),
            totalNight: event.totalNight.toString(),
            room: event.room.toString(),
            idRoom: event.roomModel.id,
            checkIn: event.selecetedDateFrom.toString(),
            checkOut: event.selecetedDateTo.toString(),
            price: event.wallet));

        await BookService.updateNofRoom(BookModels(
            idRoom: event.roomModel.id, noofRoom: event.roomModel.noFRoom - 1));
      }

      yield OnTransferPage(
          event.idOrder, event.uid, event.wallet, event.roomModel);
    } else if (event is GotoSendEvidence) {
      yield OnSendEvidence(event.idOrder, event.room, event.wallet);
    } 
    else if (event is GotoCreateRoom) {
      yield OnCreateRoom();
    }
    else if (event is GotoEditRoom) {
      yield OnEditRoom(event.room);
    }
     else if (event is GotoBookingDetail) {
      yield OnBookingDetail(event.book, event.pageEvent);
    } else if (event is GotoNewestPage) {
      var book = await BookService.getBook();
      yield OnNewestPage(book);
    }
  }
}
