require "http"

class TmdbService
  TMDB_API_URL = "https://api.themoviedb.org/3".freeze

  def initialize
    @api_key = ENV["TMDB_API_KEY"]
  end

  # def fetch_movie(movie_id)
  #   response = HTTP.get("#{TMDB_API_URL}/movie/#{movie_id}", params: { api_key: @api_key})

  #   return nil unless response.status.success?

  #   movie_data = response.parse
  #   {
  #     title: movie_data["title"],
  #     genre: movie_data["genres"].map { |g| g["name"] }.join(", "),
  #     description: movie_data["overview"],
  #     release_date: movie_data["release_date"],
  #     author_or_director: movie_data["director"],
  #     thumbnail_url: "https://image.tmdb.org/t/p/w500#{movie_data['poster_path']}",
  #     api_id: movie_data["id"]
  #   }
  # end
end