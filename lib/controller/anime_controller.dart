import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_home_exam/model/anime_model.dart';

import '../graphql/graphql_client.dart';

class AnimeAsyncNotifier extends StateNotifier<AsyncValue<List<Media>>> {
  AnimeAsyncNotifier(this.graphQlProvider) : super(const AsyncLoading());

  final GraphQLService graphQlProvider;
  List<Media> media = [];

  Future<void> getData(int page) async {
    print(page);
    state = const AsyncLoading();
    try {
      Anime response = await graphQlProvider.getAnime(page);
      if (response.page != null) {
        media = response.page!.media!;
        state = AsyncData(media);
      } else {
        state = const AsyncError('Could not fetch anime list...');
      }
    } catch (e) {
      state = const AsyncError('Could not fetch anime list...');
      debugPrint(e.toString());
    }
  }

  Future<void> fetchNextPage(int page) async {
    try {
      Anime response = await graphQlProvider.getAnime(page);
      if (response.page != null) {
        media.addAll(response.page!.media!);
        state = AsyncData(media);
      } else {
        state = const AsyncError('Could not fetch anime list...');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFilteredData(String filterString) async {
    List<Media> searchedData = [];
    state = const AsyncLoading();
    searchedData.clear();
    media.forEach((element) {
      if (element.title!.english == null) {
        return;
      }
      if (element.title!.english!
          .toLowerCase()
          .contains(filterString.toLowerCase())) {
        searchedData.add(element);
      }
    });
    state = AsyncData(searchedData);
  }
}
