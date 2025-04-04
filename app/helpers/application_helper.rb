module ApplicationHelper
  # カテゴリーごとのパスを定義
  def category_path(category)
    category.present? ? category_url(category) : categories_path
  end

  def default_meta_tags
    {
      site: 'DrinkCollection',
      title: '新たなお酒との出会い',
      reverse: true,
      charset: 'utf-8',
      separator: '|',
      description: 'お酒好きや興味のある方にぴったりのwebアプリ!',
      keywords: 'お酒,飲み物,バー,カクテル,ビール',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      
      og: {
        site_name: 'DrinkCollection',
        title: 'DrinkCollection',
        description: 'お酒好きや興味のある方にぴったりのwebアプリ!',
        type: 'website',
        url: request.original_url,
        image: image_url('ogp-image.png'),
        locale: 'ja_JP',
      },

      twitter: {
        card: 'summary_large_image',
        site: '@snowflowerhaku',
        title: 'DrinkCollection',
        description: 'お酒好きや興味のある方にぴったりのwebアプリ!',
        image: image_url('ogp-image.png')
      }
    }
  end
end
