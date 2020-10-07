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
  final idUser;
  final status;

  SendApproval(this.idOrder,this.idUser, this.status);

  @override
  List<Object> get props => [];
}
class SendCheckIn extends SendEvidenceEvent {
  final idOrder;

  SendCheckIn(this.idOrder,);

  @override
  List<Object> get props => [];
}
class Scan extends SendEvidenceEvent {
  final idOrder;

  Scan(this.idOrder,);

  @override
  List<Object> get props => [];
}
class SendCheckOut extends SendEvidenceEvent {
  final idOrder;

  SendCheckOut(this.idOrder,);

  @override
  List<Object> get props => [];
}

class OnPickedImage extends SendEvidenceEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
class SendReview extends SendEvidenceEvent {
  final rate;
  final review;
  final idRoom;
  

  SendReview(this.rate, this.review, this.idRoom);
  @override
  List<Object> get props => throw UnimplementedError();
}
