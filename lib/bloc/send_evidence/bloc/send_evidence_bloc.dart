import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'send_evidence_event.dart';
part 'send_evidence_state.dart';

class SendEvidenceBloc extends Bloc<SendEvidenceEvent, SendEvidenceState> {
  @override
  Stream<SendEvidenceState> mapEventToState(
    SendEvidenceEvent event,
  ) async* {
    if (event is LoadSendEvidence) {
      yield OnSendEvidencePage();
    } else if(event is OnPickedImage){
      SendEvidence data = state.sendEvidence;
            yield OnSendEvidencePage(sendEvidence: data.copyWith(data));

    }
  }

  @override
  SendEvidenceState get initialState => SendEvidenceInitial(sendEvidence: SendEvidence());
}
