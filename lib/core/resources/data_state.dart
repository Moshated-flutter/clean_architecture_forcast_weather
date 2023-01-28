abstract class DataState<T> {
  final T? data;
  final String? error;

  const DataState(this.data, this.error);
}

class DataSucces<T> extends DataState<T> {
  const DataSucces(T? data) : super(data, null);
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(String error) : super(null, error);
}
