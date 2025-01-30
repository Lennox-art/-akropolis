import 'package:akropolis/utils/constants.dart';
import 'package:akropolis/main.dart';
import 'package:network_service/network_service.dart';

const NetworkConnection mediaStackNewsApiConnection = NetworkConnection(
  host: 'api.mediastack.com',
  contextPath: "/v1",
  scheme: NetworkScheme.http,
);

Future<NetworkResponse<Map<String, dynamic>>> sendGetMediaStackNews({
  int page = 0,
  int pageSize = 100,
  String? language,
  String? domains,
  String? excludeDomains,
  String? keywords,
  List<String> sources = const [],
  List<String> countries = const [],
  DateTime? from,
  DateTime? to,
}) async {

  String? date;
  if(from != null) date = from.toIso8601String();
  if(to != null && from != null) date = ",${to.toIso8601String()}";

  Uri uri = mediaStackNewsApiConnection.buildUrl(
    path: "news",
    parameters: {
      "access_key" : mediaStackApiKey,
      "keywords": keywords,
      "languages": language,
      "countries": countries.join(","),
      "domains": domains,
      "excludeDomains": excludeDomains,
      "sources": sources.join(","),
      "date": date?.toString(),
      "limit": pageSize.toString(),
      "offset": page.toString(),
    },
  );

  NetworkRequest request = NetworkRequest.plain(
    params: NetworkRequestParameters(
      uri: uri,
      requestMethod: RequestMethod.get,
    ),
  );
  return ns.sendRequest(request: request);
}
