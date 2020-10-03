import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mataram2/models/models.dart';
import 'package:mataram2/services/services.dart';
import 'package:mataram2/shared/shared.dart';
import 'package:meta/meta.dart';

part 'send_evidence_event.dart';
part 'send_evidence_state.dart';

class SendEvidenceBloc extends Bloc<SendEvidenceEvent, SendEvidenceState> {
  @override
  Stream<SendEvidenceState> mapEventToState(
    SendEvidenceEvent event,
  ) async* {
    if (event is LoadSendEvidence) {
      SendEvidence data = state.sendEvidence;
      yield SendEvidenceInitial(sendEvidence: SendEvidence());
      print("event.room.id");
      print(data.image);
      String evidence;
      evidence = await uploadImage(data.image);
      print(evidence);

      await BookService.updateUser(
          BookModels(idOrder: event.idOrder, evidence: evidence));
      yield OnSuccess(sendEvidence: data.copyWith(data));
    } else if (event is OnPickedImage) {
      SendEvidence data = state.sendEvidence;

      yield OnSendEvidencePage(sendEvidence: data.copyWith(data));
    } else if (event is SendCheckIn) {
      DateTime time = DateTime.now();
      print("book[0].roomName");
      print(event.idOrder);
      List<BookModels> book = await BookService.getBook();
      String statusCheckin;
      book.forEach((element) {
        statusCheckin = element.statuscheckIn;
      });
      print("statusCheckin");
      print(statusCheckin);
      if (statusCheckin == "0" || statusCheckin == null) {
        await BookService.checkIn(BookModels(
          idOrder: event.idOrder,
          checkIn: time.toString(),
        ));
        yield ScanResult(statuCheckin: statusCheckin);
      } else if (statusCheckin == "1") {
        yield Errors(message: 'This Room has been check-in');
      } else if (statusCheckin == "2") {
        yield Errors(message: 'This Room has been check-out');
      }
    } else if (event is SendCheckOut) {
      DateTime time = DateTime.now();
      List<BookModels> book = await BookService.getBook();
      String statusCheckin;
      book.forEach((element) {
        statusCheckin = element.statuscheckIn;
      });
      if (statusCheckin == "1") {
        await BookService.checkOut(BookModels(
          idOrder: event.idOrder,
          checkOut: time.toString(),
        ));
        yield ScanResult(statuCheckin: statusCheckin);
      } else if (statusCheckin == "2") {
        yield Errors(message: 'This Room has been check-out');
      } else {
        yield Errors(message: 'Please Check Your ticket');
      }
    } else if (event is SendApproval) {
      // yield OnSuccess();
      print("a.fcmToken");
      print("b");
      await BookService.approve(
          BookModels(idOrder: event.idOrder, status: event.status));
      var a = await UserServices.getUser(event.idUser);
      print(a.fcmToken);
      await Network.sendAndRetrieveMessage(a.fcmToken);

      yield OnSuccess();
    } else if (event is SendReview) {
      await BookService.updateRate(
          RoomModel(
            rate: event.rate.toString(),
            review: event.review,
          ),
          event.idRoom);

      yield OnSuccess();
    }
  }

  @override
  SendEvidenceState get initialState =>
      SendEvidenceInitial(sendEvidence: SendEvidence());
}
