import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:take_home_exam/graphql/graphql_queries.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_home_exam/provider/AnimeProvider.dart';
import 'package:take_home_exam/routing/app_routes.dart';

import '../model/anime_model.dart';

class AnimeScreen extends ConsumerStatefulWidget {
  const AnimeScreen({Key? key}) : super(key: key);

  @override
  _AnimeScreenState createState() => _AnimeScreenState();
}

class _AnimeScreenState extends ConsumerState<AnimeScreen> {
  final title = "Anime List";
  int page = 1;
  late ScrollController _controller;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
    controller.addListener(() {
      ref
          .read(animeAsyncNotifier.notifier)
          .getFilteredData(controller.text);
    });
    _getAnimeList(page);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.atEdge) {
      bool isBottom = _controller.position.pixels != 0;
      if (isBottom) {
        print('At the bottom');
        ref.read(animeAsyncNotifier.notifier).fetchNextPage(page);
      }
    }
  }

  _getAnimeList(int page) {
    ref.read(animeAsyncNotifier.notifier).getData(page);
  }

  Widget animeItemBuilder(context, int index, List<Media> anime) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, animeDetailScreen,
          arguments: anime[index]),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: anime[index].bannerImage ?? "",
              imageBuilder: (context, imageProvider) => Container(
                height: 130.0,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(Icons.image),
                ),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withOpacity(0.7),
                      Colors.red.withOpacity(0.7),
                    ],
                  ),
                ),
                height: 30,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    anime[index].title?.english ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  Container searchBar() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    height: 30.0,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey)),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        Flexible(
          child: TextFormField(
            decoration: const InputDecoration(
              contentPadding:
              EdgeInsets.only(left: 10.0, bottom: 13.0),
              hintText: 'search',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
            controller: controller,
          ),
        ),
      ],
    ),
  );

  Future<void> _refreshData() async {
    page = 1;
    ref.refresh(animeAsyncNotifier.notifier).getData(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            searchBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: ref.watch(animeAsyncNotifier).when(
                    data: (data) {
                      page += 1;
                      return data.isNotEmpty
                          ? ListView.builder(
                          controller: _controller,
                          itemCount: data.length,
                          itemBuilder: (context, index) =>
                              animeItemBuilder(context, index, data))
                          : const Text('No records Available.');
                    },
                    error: (object, stackTrace) {
                      debugPrint(object.toString());
                      return Text(object.toString());
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
