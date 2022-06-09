class Anime {
  Anime({
      Page? page,}){
    _page = page;
}

  Anime.fromJson(dynamic json) {
    _page = json['Page'] != null ? Page.fromJson(json['Page']) : null;
  }
  Page? _page;

  Page? get page => _page;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_page != null) {
      map['Page'] = _page?.toJson();
    }
    return map;
  }

}

class Page {
  Page({
      List<Media>? media,}){
    _media = media;
}

  Page.fromJson(dynamic json) {
    if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        _media?.add(Media.fromJson(v));
      });
    }
  }
  List<Media>? _media;

  List<Media>? get media => _media;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_media != null) {
      map['media'] = _media?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Media {
  Media({
      String? siteUrl, 
      String? bannerImage, 
      Title? title, 
      String? description,}){
    _siteUrl = siteUrl;
    _bannerImage = bannerImage;
    _title = title;
    _description = description;
}

  Media.fromJson(dynamic json) {
    _siteUrl = json['siteUrl'];
    _bannerImage = json['bannerImage'];
    _title = json['title'] != null ? Title.fromJson(json['title']) : null;
    _description = json['description'];
  }
  String? _siteUrl;
  String? _bannerImage;
  Title? _title;
  String? _description;

  String? get siteUrl => _siteUrl;
  String? get bannerImage => _bannerImage;
  Title? get title => _title;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['siteUrl'] = _siteUrl;
    map['bannerImage'] = _bannerImage;
    if (_title != null) {
      map['title'] = _title?.toJson();
    }
    map['description'] = _description;
    return map;
  }

}

class Title {
  Title({
      String? english, 
      String? native,}){
    _english = english;
    _native = native;
}

  Title.fromJson(dynamic json) {
    _english = json['english'];
    _native = json['native'];
  }
  String? _english;
  String? _native;

  String? get english => _english;
  String? get native => _native;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['english'] = _english;
    map['native'] = _native;
    return map;
  }

}