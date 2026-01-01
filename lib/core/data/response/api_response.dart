import 'package:divine_employee_app/core/data/response/status.dart';

class ApiReponses<T> {
  Status? status;
  T? data;
  String? message;

  ApiReponses(this.status, this.data, this.message);

  ApiReponses.loading() : status = Status.LOADING;
  ApiReponses.completed(this.data) : status = Status.COMPLETED;
  ApiReponses.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}
