String getAnimeQuery = """
query getAnimeList(\$page: Int!) {
  Page(page: \$page, perPage: 10) {
    media {
      siteUrl
      bannerImage
      title {
        english
        native
      }
      description
    }
  }
}
""";