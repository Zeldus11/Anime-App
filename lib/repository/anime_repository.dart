import 'package:take_home_exam/graphql/graphql_client.dart';
import 'package:take_home_exam/model/anime_model.dart';

class AnimeRepository {
  GraphQLService graphQLService = GraphQLService()..initGraphQL();

  Future<Anime> getAnime(int page) async {
    return await graphQLService.getAnime(page);
  }
}