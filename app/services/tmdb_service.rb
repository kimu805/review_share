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

    parse_movies(response.parse["results"])
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
    main_cast = credits["cast"].take(8).map { |cast_member| cast_member["name"] }

    {
      title: movie["title"],
      genre: genre_names(movie["genres"].map { |g| g["id"] }),
      description: movie["overview"],
      release_date: movie["release_date"],
      author_or_director: director ? director["name"] : "情報なし",
      main_cast: main_cast.join(", "),
      thumbnail_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
      api_id: movie["id"]
    }
  end

  def fetch_search_results(query)
    response = HTTP.get("#{TMDB_API_URL}/search/movie", params: {
      api_key: @api_key,
      query: query,
      language: "ja"
    })
    return [] unless response.status.success?

    parse_movies(response.parse["results"])
  end

  private
  # 映画のデータをぱーすして整理する
  def parse_movies(movies)
    movies.map do |movie|
      {
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