import '../controller/anime_controller.dart';
import '../graphql/graphql_client.dart';
import '../model/anime_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final graphqlProvider =
    Provider<GraphQLService>((ref) => GraphQLService()..initGraphQL());

final animeAsyncNotifier = StateNotifierProvider.autoDispose<AnimeAsyncNotifier,
        AsyncValue<List<Media>>>(
    (ref) => AnimeAsyncNotifier(ref.watch(graphqlProvider)));
