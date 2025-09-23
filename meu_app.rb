require_relative 'database'
require_relative 'brasil_api_service'

class MeuApp
  def initialize
    @conn = Database.connect
  end

  def sincronizar_estados
    estados_da_api = BrasilApiService.fetch_estados
    return if estados_da_api.empty?

    puts "Iniciando sincronização de #{estados_da_api.count} estados..."

    estados_da_api.each do |estado_data|
      result = @conn.exec_params('SELECT id FROM estados WHERE sigla = $1', [estado_data['sigla']])

      if result.ntuples.zero?
        sql = "INSERT INTO estados (sigla, nome, regiao) VALUES ($1, $2, $3)"
        @conn.exec_params(sql, [estado_data['sigla'], estado_data['nome'], estado_data['regiao']['nome']])
        puts "Estado #{estado_data['sigla']} inserido."
      else
        sql = "UPDATE estados SET nome = $2, regiao = $3 WHERE sigla = $1"
        @conn.exec_params(sql, [estado_data['sigla'], estado_data['nome'], estado_data['regiao']['nome']])
        puts "Estado #{estado_data['sigla']} atualizado."
      end
    end

    puts "Sincronização concluída!"
  end

  def listar_registros
    puts "\n--- Listando Estados Armazenados no Banco de Dados ---"
    result = @conn.exec("SELECT * FROM estados ORDER BY nome ASC")

    if result.ntuples.zero?
      puts "Nenhum estado encontrado no banco de dados. Execute a sincronização primeiro."
      return
    end

    result.each do |row|
      puts "ID: #{row['id']} | Sigla: #{row['sigla']} | Nome: #{row['nome']} | Região: #{row['regiao']}"
    end
    puts "----------------------------------------------------"
  end

  def fechar_conexao
    @conn.close if @conn
  end
end