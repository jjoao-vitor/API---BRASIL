require 'httparty'
require 'json'

class BrasilApiService
  include HTTParty
  base_uri 'https://brasilapi.com.br/api'

  def self.fetch_estados
    response = get('/ibge/uf/v1')
    if response.success?
      JSON.parse(response.body)
    else
      puts "Erro ao buscar dados da API: #{response.code}"
      []
    end
  end
end