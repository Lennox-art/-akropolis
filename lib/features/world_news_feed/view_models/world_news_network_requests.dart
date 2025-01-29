import 'package:akropolis/utils/constants.dart';
import 'package:akropolis/main.dart';
import 'package:network_service/network_service.dart';

const NetworkConnection newsApiConnection = NetworkConnection(
  host: 'newsapi.org',
  contextPath: "/v2",
  scheme: NetworkScheme.https,
);

Future<NetworkResponse<Map<String, dynamic>>> getEverythingNewsApi({
  int page = 1,
  int pageSize = 100,
  String? language,
  String? domains,
  String? excludeDomains,
  String? keywords,
  List<String> sources = const [],
  DateTime? from,
  DateTime? to,
}) async {
  assert(pageSize < 101);

  Uri uri = newsApiConnection.buildUrl(
    path: "everything",
    parameters: {
      "apiKey" : newsApiKey,
      "q": keywords,
      "language": language,
      "domains": domains,
      "excludeDomains": excludeDomains,
      "sources": sources.join(","),
      "from": from?.toIso8601String(),
      "to": to?.toIso8601String(),
      "pageSize": pageSize.toString(),
      "page": page.toString(),
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
