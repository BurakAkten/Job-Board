abstract class BaseState {
  const BaseState();
}

class BaseInitialState extends BaseState {
  const BaseInitialState();
}

class BaseLoadingSate extends BaseState {
  final bool isLoading;
  const BaseLoadingSate(this.isLoading);
}

class BaseCompletedState extends BaseState {
  dynamic data;
  BaseCompletedState({this.data});
}

class BaseErrorState extends BaseState {
  final String? errorMessage;
  BaseErrorState({this.errorMessage});
}
