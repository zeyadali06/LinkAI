class RequestResault<S, F> {
  const RequestResault();
  factory RequestResault.success(S data) = RequestSuccess<S, F>;
  factory RequestResault.failure(F data) = RequestFailed<S, F>;
}

class RequestSuccess<S, F> extends RequestResault<S, F> {
  final S data;
  const RequestSuccess(this.data);
}

class RequestFailed<S, F> extends RequestResault<S, F> {
  final F data;
  const RequestFailed(this.data);
}
