import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_board/base/states/base_state.dart';
import 'package:job_board/translations/locale_keys.g.dart';
import 'package:job_board/utils/extensions/list_extension.dart';
import 'package:job_board/utils/extensions/string_extension.dart';
import '../../../domain/dtos/job_dto.dart';
import '../job_board_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobBoardViewModel extends Cubit<BaseState> {
  final JobBoardService service;

  JobBoardViewModel(this.service) : super(BaseInitialState()) {
    init();
  }
  bool _isLoading = false;

  List<JobResponse> _jobs = [];
  List<JobResponse> _normalJobs = [];
  List<JobResponse> _acceptedJobs = [];

  Future<void> init() async {
    isLoading = true;
    var response = await service.getJobs();
    if (response.isSuccess && response.data != null) {
      _jobs = JobResponse.listFromJson(response.data);
      _reInitJobs();
    } else {
      emit(BaseErrorState(errorMessage: response.errorMessage ?? LocaleKeys.sthWentWrong.locale));
    }
  }

  void changeTypeOfJob(int index, JobType type) {
    var job = _normalJobs[index];
    _normalJobs[index].type = type;
    _reInitJobs();
    Fluttertoast.showToast(msg: "${job.title} was ${JobType.Accepted == type ? "Accepted" : "Rejected"}", timeInSecForIosWeb: 3);
  }

  void _reInitJobs() {
    _normalJobs = _jobs.where((j) => (j.type == JobType.Normal)).toList();
    _normalJobs.bubbleSort((j1, j2) => j1.datePosted != null && j2.datePosted != null ? j1.datePosted!.compareTo(j2.datePosted!) : 0);
    _acceptedJobs = _jobs.where((j) => (j.type == JobType.Accepted)).toList();
    _acceptedJobs.bubbleSort((j1, j2) =>
        j1.expectedDeliveryDate != null && j2.expectedDeliveryDate != null ? j1.expectedDeliveryDate!.compareTo(j2.expectedDeliveryDate!) : 0);
    emit(BaseCompletedState(data: {JobType.Accepted: _acceptedJobs, JobType.Normal: _normalJobs}));
  }

  void reloadState() {
    if (!isLoading) emit(BaseLoadingSate(_isLoading));
  }

  //Getters
  bool get isLoading => _isLoading;

  //Setters
  set isLoading(bool value) {
    _isLoading = value;
    scheduleMicrotask(() {
      emit(BaseLoadingSate(_isLoading));
    });
  }
}
