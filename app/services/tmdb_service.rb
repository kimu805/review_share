require "http"

class TmdbService
  TMDB_API_URL = "https://api.themoviedb.org/3".freeze

  def initialize
    @api_key = ENV["TMDB_API_KEY"]
    @genres = fetch_genres
  end

  # 人気映画を取得するメソッド
  def fetch_popular_movies
    response = HTTP.get("#{TMDB_API_URL}/movie/popular", params: { 
      api_key: @api_key,
      region: "JP",
      language: "ja-JP"
    })
    return [] unless response.status.success?

    parse_movies(response.parse["results"])
  end

  # 新着映画を取得するメソッド
  def fetch_now_playing_movies
    response = HTTP.get("#{TMDB_API_URL}/movie/now_playing", params: { 
      api_key: @api_key,
      region: "JP",
      language: "ja-JP"
    })
    return [] unless response.status.success?

    movies = parse_movies(response.parse["results"])
    sort_by_release_date(movies)

  end

  # 映画の詳細を取得するメソッド
  def fetch_movie_detail(movie_id)
    response = HTTP.get("#{TMDB_API_URL}/movie/#{movie_id}", params: {
      api_key: @api_key,
      language: "ja-JP"
    })
    return nil unless response.status.success?
    
    movie = response.parse
    # クレジット情報（監督やキャスト）を取得
    credits_response = HTTP.get("#{TMDB_API_URL}/movie/#{movie_id}/credits", params: {
      api_key: @api_key,
      language: "ja-JP"
    })
    return nil unless credits_response.status.success?

    credits = credits_response.parse

    director = credits["crew"].find { |crew_member| crew_member["job"] == "Director" }
    main_casts = credits["cast"].take(8).map { |cast_member| cast_member["name"] }

    {
      type: "映画",
      title: movie["title"],
      genre: genre_names(movie["genres"].map { |g| g["id"] }),
      description: movie["overview"],
      release_date: movie["release_date"],
      author_or_director: director ? director["name"] : "情報なし",
      main_casts: main_casts.join(", "),
      thumbnail_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
      api_id: movie["id"]
    }
  end

  # 検索結果を取得するメソッド
  def fetch_search_results(query)
    response = HTTP.get("#{TMDB_API_URL}/search/movie", params: {
      api_key: @api_key,
      query: query,
      language: "ja"
    })
    return [] unless response.status.success?

    movies = parse_movies(response.parse["results"])
    sort_by_release_date(movies)
  end

  # クレジット情報（監督やキャスト）を取得するメソッド
  def fetch_credits(movie_id)
    response = HTTP.get("#{TMDB_API_URL}/movie/#{movie_id}/credits", params: {
      api_key: @api_key,
      language: "ja"
    })
    return {director: nil, cast: [] } unless response.status.success?

    credits = response.parse
    director = credits["crew"].find { |person| person["job"] == "Director" }
    casts = credits["cast"].take(8).map { |person| person["name"] }

    {
      author_or_director: director&.dig("name"),
      main_casts: casts
    }
  end

  private
  # 映画のデータをぱーすして整理する
  def parse_movies(movies)
    movies.map do |movie|
      {
        type: "映画",
        title: movie["title"],
        genre: genre_names(movie["genre_ids"]),
        description: movie["overview"],
        release_date: movie["release_date"],
        author_or_director: movie["director"],
        thumbnail_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
        api_id: movie["id"]
      }  
    end
  end

  def sort_by_release_date(movies)
    movies.sort_by { |movie| movie[:release_date] }.reverse
  end

  # ジャンル名を取得するメソッド
  def fetch_genres
    response = HTTP.get("#{TMDB_API_URL}/genre/movie/list", params: { 
      api_key: @api_key,
      language: "ja-JP"
    })
    return [] unless response.status.success?

    genres_data = response.parse["genres"]
    genres_data.each_with_object({}) do |genre, hash|
      hash[genre["id"]] = genre["name"]
    end
  end

  # ジャンルIDをジャンル名に変換
  def genre_names(genre_ids)
    genre_ids.map {
      |id| @genres[id]
    }.join(", ")
  end
end