import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/base/constants/app_constants.dart';
import 'package:job_board/base/states/base_state.dart';
import 'package:job_board/base/views/base_view.dart';
import 'package:job_board/domain/dtos/job_dto.dart';
import 'package:job_board/screens/job_board/job_board_service.dart';
import 'package:job_board/screens/job_board/viewmodels/job_board_viewmodel.dart';
import 'package:job_board/screens/job_board/views/jobs_view.dart';
import 'package:job_board/screens/job_board/widgets/try_again_widget.dart';
import 'package:job_board/translations/locale_keys.g.dart';
import 'package:job_board/utils/extensions/context_extension.dart';
import 'package:job_board/utils/extensions/string_extension.dart';

class JobBoardScreen extends StatefulWidget {
  const JobBoardScreen({Key? key}) : super(key: key);

  @override
  State<JobBoardScreen> createState() => _JobBoardScreenState();
}

class _JobBoardScreenState extends State<JobBoardScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text(LocaleKeys.appBarTitle.locale)),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.black.withOpacity(0.5),
            labelStyle: context.textTheme.subtitle1,
            unselectedLabelStyle: context.textTheme.subtitle1,
            padding: EdgeInsets.only(top: AppSpacing.spacingMedium.h),
            indicatorColor: AppColors.black,
            labelPadding: EdgeInsets.only(bottom: AppSpacing.spacingMedium.h),
            tabs: [
              Text(LocaleKeys.jobs.locale),
              Text(LocaleKeys.acceptedJobs.locale),
            ],
          ),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: BaseView<JobBoardViewModel>(
                vmBuilder: (context) => JobBoardViewModel(JobBoardService()),
                listener: (context, state) => debugPrint(state.runtimeType.toString()),
                builder: (context, state) => _buildTabBarView(state as BaseCompletedState),
                errorBuilder: (context, state) => TryAgainWidget(errorState: state),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView(BaseCompletedState state) => TabBarView(
        controller: _tabController,
        children: [
          JobsView(jobs: (state.data)[JobType.Normal]),
          JobsView(isAccepted: true, jobs: (state.data)[JobType.Accepted]),
        ],
      );
}
