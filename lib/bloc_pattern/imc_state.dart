class ImcState {
  final double imc;
  ImcState({
    required this.imc,
  });
}

class ImcStateLoading extends ImcState {
  ImcStateLoading() : super(imc: 0);
}

class ImcStateError extends ImcState {
  String message;
  ImcStateError({
    required this.message,
  }) : super(imc: 0);
}
