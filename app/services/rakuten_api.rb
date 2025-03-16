require "net/http"
require "uri"
require "json"

class RakutenApi
  BASE_URL = "https://app.rakuten.co.jp/services/api/IchibaItem/Search/20220601"
  APP_ID = ENV["RAKUTEN_APP_ID"]
  AFFILIATE_ID = ENV["RAKUTEN_AFFILIATE_ID"]

  # カテゴリーごとのジャンルIDを設定
  GENRE_IDS = {
    "ワイン" => 100317,
    "日本酒" => 100337,
    "ビール" => 100324,
    "ウイスキー" => 100330,
    "焼酎" => 110662,
    "リキュール" => 110609
  }

  def self.search_items(keyword, category = nil)
    uri = URI(BASE_URL)
    genre_id = GENRE_IDS[category] || nil
    params = {
      applicationId: APP_ID,
      affiliateId: AFFILIATE_ID,
      keyword: keyword,
      genreId: genre_id, # カテゴリーがあればジャンルIDを設定
      hits: 4, # 取得件数
      sort: "-reviewCount" # レビューが多い順
    }
    uri.query = URI.encode_www_form(params)

    Rails.logger.info "楽天APIリクエストURL: #{uri}"

    begin
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)

      if result["Items"].present?
        return result["Items"].map { |item| item["Item"] }
      else
        Rails.logger.warn "楽天APIの検索結果が空です。"
        return []
      end
    rescue JSON::ParserError => e
      Rails.logger.error "JSONパースエラー: #{e.message}"
      return []
    rescue StandardError => e
      Rails.logger.error "楽天APIの取得に失敗: #{e.message}"
      return []
    end
  end
end
