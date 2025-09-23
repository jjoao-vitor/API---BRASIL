require_relative 'meu_app.rb'
require_relative 'database.rb'

def run
  Database.create_table

  app = MeuApp.new

  puts "Bem-vindo ao App de consulta à BrasilAPI!"
  puts "O que você deseja fazer?"
  puts "1. Sincronizar dados dos estados da API para o banco de dados"
  puts "2. Listar estados armazenados no banco de dados"
  puts "3. Sair"

  loop do
    print "> "
    opcao = gets.chomp

    case opcao
    when '1'
      app.sincronizar_estados
    when '2'
      app.listar_registros
    when '3'
      puts "Até logo!"
      break
    else
      puts "Opção inválida. Tente novamente."
    end
  end

  app.fechar_conexao
end

run