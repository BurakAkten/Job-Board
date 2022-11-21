import 'dart:async';
import 'package:job_board/base/states/base_state.dart';
import 'package:job_board/base/viewmodels/base_viewmodel.dart';
import 'package:job_board/translations/locale_keys.g.dart';
import 'package:job_board/utils/extensions/list_extension.dart';
import 'package:job_board/utils/extensions/string_extension.dart';
import '../../../domain/dtos/job_dto.dart';
import '../job_board_service.dart';

class JobBoardViewModel extends BaseViewModel {
  final JobBoardService service;

  JobBoardViewModel(this.service);

  List<JobResponse> _jobs = [];
  List<JobResponse> _normalJobs = [];
  List<JobResponse> _acceptedJobs = [];

  @override
  Future<void> init() async {
    if (!(state is BaseLoadingSate)) emit(BaseLoadingSate(true));
    var response = await service.getJobs();
    if (response.isSuccess && response.data != null) {
      _jobs = JobResponse.listFromJson(response.data);
      _reInitJobs();
    } else {
      emit(ShowErrorToastState(errorMessage: response.errorMessage ?? LocaleKeys.sthWentWrong.locale));
      emit(BaseErrorState(errorMessage: response.errorMessage ?? LocaleKeys.sthWentWrong.locale));
    }
  }

  void changeTypeOfJob(int index, JobType type) {
    var job = _normalJobs[index];
    _normalJobs[index].type = type;
    emit(ShowSuccessToastState(message: "${job.title} was ${JobType.Accepted == type ? "Accepted" : "Rejected"}"));
    _reInitJobs();
  }

  void _reInitJobs() {
    _normalJobs = _jobs.where((j) => (j.type == JobType.Normal)).toList();
    _normalJobs.bubbleSort((j1, j2) => j1.datePosted != null && j2.datePosted != null ? j1.datePosted!.compareTo(j2.datePosted!) : 0);
    _acceptedJobs = _jobs.where((j) => (j.type == JobType.Accepted)).toList();
    _acceptedJobs.bubbleSort((j1, j2) =>
        j1.expectedDeliveryDate != null && j2.expectedDeliveryDate != null ? j1.expectedDeliveryDate!.compareTo(j2.expectedDeliveryDate!) : 0);
    emit(BaseCompletedState(data: data));
  }

  //Getters
  @override
  Map<JobType, List<JobResponse>> get data => {JobType.Accepted: _acceptedJobs, JobType.Normal: _normalJobs};
}
