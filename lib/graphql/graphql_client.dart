import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:take_home_exam/model/anime_model.dart';
import '../utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'graphql_queries.dart';


abstract class GraphQLApi {
  Future<void> initGraphQL();

  Future<Anime> getAnime(int page);
}

class GraphQLService extends GraphQLApi {
  GraphQLService();

  late GraphQLClient _client;

  @override
  Future<void> initGraphQL() async {
    final _httpLink = HttpLink(baseUrl);

    _client =
        GraphQLClient(link: _httpLink, cache: GraphQLCache(store: HiveStore()));

    debugPrint('GraphQL initialised');
  }

  @override
  Future<Anime> getAnime(int page) async {
    // TODO: implement getAnime
    final options = QueryOptions(
        document: gql(getAnimeQuery),
        variables: <String, String>{'page': page.toString()});

    try {
      final result = await _client.query(options);

      final animeResponse = Anime.fromJson(result.data!);

      debugPrint(animeResponse.page?.media?[0].siteUrl);

      return animeResponse;
    } catch (e) {
      rethrow;
    }
  }

}
