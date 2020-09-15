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
      // yield  SendEvidenceInitial(sendEvidence: SendEvidence());
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
    } 
    else if (event is SendApproval) {
      await BookService.approve(
          BookModels(idOrder: event.idOrder, status: event.status));

      yield OnSuccess();
    }
    else if (event is SendReview) {
      await BookService.updateRate(
          RoomModel(rate: event.rate, review: event.review,),   event.idRoom);

      yield OnSuccess();
    }
  }

  @override
  SendEvidenceState get initialState =>
      SendEvidenceInitial(sendEvidence: SendEvidence());
}
