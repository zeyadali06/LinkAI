class RequestResault<S, F> {
  const RequestResault();
  factory RequestResault.success(S data) = Success<S, F>;
  factory RequestResault.failure(F data) = Failed<S, F>;
}

class Success<S, F> extends RequestResault<S, F> {
  final S data;
  const Success(this.data);
}

class Failed<S, F> extends RequestResault<S, F> {
  final F data;
  const Failed(this.data);
}
