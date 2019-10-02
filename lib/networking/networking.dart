const String apiKey = 'AIzaSyAqnBxr-G5811raZcYmWODowYofAnd6TjU';
const String baseUrl =
    'https://translation.googleapis.com/language/translate/v2';

Map<String, String> getHeaders() {
  return <String, String>{
    'Authorization': 'Bearer$apiKey',
  };
}
