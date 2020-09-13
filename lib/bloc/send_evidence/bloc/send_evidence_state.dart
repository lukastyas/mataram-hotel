part of 'send_evidence_bloc.dart';

@immutable
abstract class SendEvidenceState {
  final SendEvidence sendEvidence;

  SendEvidenceState({this.sendEvidence});
}

class SendEvidenceInitial extends SendEvidenceState {
    final SendEvidence sendEvidence;

  SendEvidenceInitial({this.sendEvidence});

}

class OnSendEvidencePage extends SendEvidenceState {
  final SendEvidence sendEvidence;

  OnSendEvidencePage({this.sendEvidence});
}
class OnSuccess extends SendEvidenceState {
  final SendEvidence sendEvidence;

  OnSuccess({this.sendEvidence});
}

class SendEvidence {
  File image;

  SendEvidence({this.image});

  SendEvidence copyWith(SendEvidence data) =>
      SendEvidence(image: data.image ?? this.image);
}
