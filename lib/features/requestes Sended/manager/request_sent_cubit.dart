import 'package:damma_project/features/requestes%20Sended/data/models/requested_sended_model/requested_sended_model.dart';
import 'package:damma_project/features/requestes%20Sended/data/repos/request_sent_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_sent_state.dart';

class RequestSentCubit extends Cubit<RequestSentState> {
  final RequestSentRepo requestSentRepo;

  RequestSentCubit(this.requestSentRepo) : super(RequestSentInitial());

  Future<void> fetchSentRequests() async {
    emit(RequestSentLoading());
    try {
      final requests = await requestSentRepo.getSentRequests();
      emit(RequestSentSuccess(requests));
    } catch (e) {
      emit(RequestSentFailure('Failed to load requests: ${e.toString()}'));
    }
  }

  Future<void> cancelRequest(int requestId) async {
    final currentState = state;
    try {
      await requestSentRepo.cancelRequest(requestId);
      emit(RequestCancelled(requestId));
      if (currentState is RequestSentSuccess) {
        emit(RequestSentSuccess(currentState.sentRequests));
      }
    } catch (e) {
      emit(RequestSentFailure('Failed to cancel request: ${e.toString()}'));
      // Revert to previous state
      if (currentState is RequestSentSuccess) {
        emit(currentState);
      }
    }
  }
}
