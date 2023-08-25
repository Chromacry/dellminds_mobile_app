class GlobalConstants {
  static const Map<String, int> STATUS_CODES = {
    'SUCCESS_CODE': 200,
    'INTERNAL_SERVER_ERROR_CODE': 500,
    'BAD_REQUEST_CODE': 400,
    'UNAUTHORIZE_CODE': 401,
  };

  static const Map<String, String> STATUS_ERROR_MSGS = {
    'INTERNAL_SERVER_ERROR': "Internal Server Error!",
    'BAD_REQUEST_ERROR': "Bad Request! Invalid or Missing parameters..",
    'UNAUTHORIZE_ERROR': "Unauthorized Access!",
  };

  static const Map<String, String> CLIENT_STATUS_MSGS = {
    'SUCCESSFUL_LOGIN': 'Successfully logged in',
  };

  static const String currentUser = 'system';
}
