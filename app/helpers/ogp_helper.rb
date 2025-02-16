module OgpHelper
  def default_ogp
    {
      title: "DrinkCollection - お酒の掲示板",
      description: "お酒の情報を共有し、あなたにぴったりの一杯を見つけよう！",
      image: asset_path("default-ogp.png"),
      url: request.original_url
    }
  end

  def ogp_meta_tags(ogp = {})
    ogp = default_ogp.merge(ogp) # デフォルト値を適用

    tag.meta(property: "og:title", content: ogp[:title]) +
    tag.meta(property: "og:description", content: ogp[:description]) +
    tag.meta(property: "og:image", content: ogp[:image]) +
    tag.meta(property: "og:url", content: ogp[:url]) +
    tag.meta(name: "twitter:card", content: "summary_large_image") +
    tag.meta(name: "twitter:title", content: ogp[:title]) +
    tag.meta(name: "twitter:description", content: ogp[:description]) +
    tag.meta(name: "twitter:image", content: ogp[:image])
  end
end
