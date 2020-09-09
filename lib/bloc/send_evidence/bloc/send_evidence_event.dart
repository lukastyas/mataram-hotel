part of 'send_evidence_bloc.dart';

@immutable
abstract class SendEvidenceEvent  extends Equatable{}
class LoadSendEvidence extends SendEvidenceEvent {

  @override
  List<Object> get props => [];
}

class OnPickedImage extends SendEvidenceEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}