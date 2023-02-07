class DataResponse<T> {
  Status status;

  T? data;
  String? message;
  int? statusCode;
  DataResponse.sucess(this.data) : status = Status.success;
  DataResponse.error(this.message, [this.statusCode]) : status = Status.error;
}

enum Status { success, error }
