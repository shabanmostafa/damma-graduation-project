part of 'request_sent_cubit.dart';

abstract class RequestSentState {}

class RequestSentInitial extends RequestSentState {}

class RequestSentLoading extends RequestSentState {}

class RequestSentSuccess extends RequestSentState {
  final RequestedSendedModel sentRequests;

  RequestSentSuccess(this.sentRequests);
}

class RequestSentFailure extends RequestSentState {
  final String error;

  RequestSentFailure(this.error);
}

class RequestCancelled extends RequestSentState {
  final int requestId;

  RequestCancelled(this.requestId);
}
