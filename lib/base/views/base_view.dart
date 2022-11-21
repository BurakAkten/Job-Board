import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_board/base/states/base_state.dart';
import 'package:job_board/translations/locale_keys.g.dart';
import 'package:job_board/utils/extensions/context_extension.dart';
import 'package:job_board/utils/extensions/string_extension.dart';
import '../viewmodels/base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatelessWidget {
  final T Function(BuildContext)? vmBuilder;
  final Widget Function(BuildContext, BaseState) builder;
  final Function(BuildContext, BaseState) listener;
  final Widget Function(BuildContext, BaseErrorState)? errorBuilder;

  const BaseView({
    Key? key,
    required this.vmBuilder,
    required this.builder,
    required this.listener,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => vmBuilder!(context),
      child: BlocConsumer<T, BaseState>(
        listener: (context, state) {
          if (state is ShowSuccessToastState)
            Fluttertoast.showToast(msg: state.message, timeInSecForIosWeb: 3);
          else if (state is ShowErrorToastState) Fluttertoast.showToast(msg: state.errorMessage, timeInSecForIosWeb: 3, backgroundColor: Colors.red);
          listener(context, state);
        },
        builder: (context, state) => _buildScreenContent(context, state),
      ),
    );
  }

  Widget _buildScreenContent(BuildContext context, BaseState state) => Container(
        child: Stack(
          children: [
            if (state is BaseCompletedState) builder(context, state),
            if (state is BaseErrorState)
              errorBuilder != null
                  ? errorBuilder!(context, state)
                  : Center(child: Text("${state.errorMessage ?? LocaleKeys.sthWentWrong.locale}", style: context.textTheme.bodyText1)),
            if ((state is BaseLoadingSate && state.isLoading) || state is BaseInitialState) const Center(child: CircularProgressIndicator.adaptive()),
          ],
        ),
      );
}
