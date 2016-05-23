require 'net/http' #require the net/http library so we can make GET requests
require 'json' #required to parse response

class PokemonService

  def get(url: url = "http://pokeapi.co/api/v1/", path: path)
    uri = URI(url + path + "/")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def pokemon_information(info)
    path = "pokemon/#{info}"
    get(path: path)
  end

  def get_moves_for(pokemon)
    response = pokemon_information(pokemon)
    response["moves"].map { |move| move["name"]}
  end

  def next_evolutions_for(pokemon)
    response = pokemon_information(pokemon)
    response["evolutions"].map {|info| info["to"]}.first
  end

  def evolutions(pokemon)
    response = pokemon_information(pokemon)
    response["evolutions"].map {|info| info["to"]}.uniq
  end

  def types(pokemon)
    response = pokemon_information(pokemon)
    response["types"].map {|type| type["name"]}
  end

  def pokemon_for_type(type)
    pokemons = 0..721
    response = pokemons.select do |pokemon|
      info = pokemon_information(pokemon)
      info["types"].map {|type| type["name"]}.include? (type)
        end
  end
end
