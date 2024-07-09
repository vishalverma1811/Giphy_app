import 'package:giphy_app/core/network/network_api_services.dart';

class TrendingRepo {
  final api = NetworkApiServices();
  static const String apiKey = 'vy0Eq5Nz7aKwIGPFvTnfRXmgPfxN5LSI';

  Future<dynamic> getTrendingGifs({
    int limit = 25,
    int offset = 0,
    String rating = 'g',
    String bundle = 'messaging_non_clips',
  }) async {
    const baseUrl = 'https://api.giphy.com/v1/gifs/trending';
    final url = Uri.parse(baseUrl).replace(queryParameters: {
      'api_key': apiKey,
      'limit': limit.toString(),
      'offset': offset.toString(),
      'rating': rating,
      'bundle': bundle,
    }).toString();

    return await api.getApi(url);
  }
}
