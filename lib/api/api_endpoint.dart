class ApiEndpoint {
  const ApiEndpoint._();

  static const _baseUrl = 'http://localhost:3000/api/';

  static const login = "${_baseUrl}login";
  static const register = "${_baseUrl}register";
  static const note = "${_baseUrl}note";
  static const archiveNotes = "${_baseUrl}note/archived";
}
