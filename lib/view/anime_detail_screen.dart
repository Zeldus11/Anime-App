import 'package:flutter/material.dart';
import 'package:take_home_exam/custom_widget/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/anime_model.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Media media;
  const AnimeDetailScreen({Key? key, required this.media}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          media.title?.english ?? "", media.bannerImage ?? "", context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Native",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                media.title?.native ?? "",
                style:
                    const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Link",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  if(media.siteUrl != null){
                    _launchInBrowser(Uri.parse(media.siteUrl!));
                  }
                },
                child: Text(
                  media.siteUrl ?? "",
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                media.description ?? "",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
