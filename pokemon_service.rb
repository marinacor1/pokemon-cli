require 'net/http' #require the net/http library so we can make GET requests
require 'json' #required to parse response

class PokemonService

  def get(url: url = "http://pokeapi.co/api/v1/", path: path)
    uri = URI(url + path + "/")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
