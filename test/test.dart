import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_board/domain/dtos/job_dto.dart';
import 'package:job_board/screens/job_board/job_board_service.dart';

void main() {
  late JobBoardService service;
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    service = JobBoardService();
  });

  test("Job Service Test", () async {
    final response = await service.getJobs();

    expect(response.isSuccess, true);
    expect(response.data != null, true);

    final jobs = JobResponse.listFromJson(response.data);

    expect(jobs.isNotEmpty, true);
  });
}
