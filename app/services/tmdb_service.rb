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
      region: "JP"
      language: "ja-JP"
    })
    return [] unless response.status.success?

    parse_movies(response.parse["results"])
  end

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

  def genre_names(genre_ids)
    genre_ids.map {
      |id| @genres[id]
    }.join(", ")
  end
end