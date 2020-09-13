part of 'send_evidence_bloc.dart';

@immutable
abstract class SendEvidenceEvent extends Equatable {}

class LoadSendEvidence extends SendEvidenceEvent {
  final idOrder;

  LoadSendEvidence(this.idOrder);

  @override
  List<Object> get props => [];
}

class SendApproval extends SendEvidenceEvent {
  final idOrder;
  final status;

  SendApproval(this.idOrder, this.status);

  @override
  List<Object> get props => [];
}

class OnPickedImage extends SendEvidenceEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
