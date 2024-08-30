class SubjectNotFound implements Exception {}

class SubjectRequestFailed implements Exception {
  SubjectRequestFailed(this.message) : super();

  final String message;
}

class SubjectAddFailed extends SubjectRequestFailed {
  SubjectAddFailed(super.message);
}

class SubjectUpdateFailed extends SubjectRequestFailed {
  SubjectUpdateFailed(super.message);
}

class SubjectDeleteFailed extends SubjectRequestFailed {
  SubjectDeleteFailed(super.message);
}
