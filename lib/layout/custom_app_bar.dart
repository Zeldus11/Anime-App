import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  //CustomAppBar({required this.child, this.height = kToolbarHeight});
  CustomAppBar({required this.child, this.height = kToolbarHeight})
      : super(child: child, preferredSize: Size.fromHeight(height));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: child,
    );
  }
}

CustomAppBar customAppBar(
        String? appBarTitle, String imageUrl, BuildContext context) =>
    CustomAppBar(
      height: 130,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.red.withOpacity(0.5), BlendMode.srcOver),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      height: 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
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
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                      Text(
                        '$appBarTitle',
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

CustomAppBar emptyCustomAppBar() => CustomAppBar(
      child: Container(),
    );
