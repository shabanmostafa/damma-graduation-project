import 'package:damma_project/features/requstes_recieved/data/models/pending_friends/pending_friends.dart';
import 'package:damma_project/features/requstes_recieved/data/repos/requests_received_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'requests_received_state.dart';

class RequestsReceivedCubit extends Cubit<RequestsReceivedState> {
  final RequestsReceivedRepo requestsReceivedRepo;

  RequestsReceivedCubit(this.requestsReceivedRepo)
      : super(RequestsReceivedInitial());

  Future<void> fetchReceivedRequests() async {
    emit(RequestsReceivedLoading());
    try {
      final requests = await requestsReceivedRepo.getReceivedRequests();
      emit(RequestsReceivedSuccess(requests));
    } catch (e) {
      emit(RequestsReceivedFailure('Failed to load requests: ${e.toString()}'));
    }
  }

  Future<void> acceptRequest(int requestId) async {
    final currentState = state;
    try {
      await requestsReceivedRepo.acceptRequest(requestId);
      emit(RequestAccepted(requestId));
      if (currentState is RequestsReceivedSuccess) {
        emit(RequestsReceivedSuccess(currentState.receivedRequests));
      }
    } catch (e) {
      emit(
          RequestsReceivedFailure('Failed to accept request: ${e.toString()}'));
      if (currentState is RequestsReceivedSuccess) {
        emit(currentState);
      }
    }
  }

  Future<void> rejectRequest(int requestId) async {
    final currentState = state;
    try {
      await requestsReceivedRepo.rejectRequest(requestId);
      emit(RequestRejected(requestId));
      if (currentState is RequestsReceivedSuccess) {
        emit(RequestsReceivedSuccess(currentState.receivedRequests));
      }
    } catch (e) {
      emit(
          RequestsReceivedFailure('Failed to reject request: ${e.toString()}'));
      if (currentState is RequestsReceivedSuccess) {
        emit(currentState);
      }
    }
  }
}
