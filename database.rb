require 'pg'

class Database
  def self.connect
    PG.connect(
      dbname: 'brasil_api_app', # <- Altere para o nome do seu banco
      user: 'postgres',       # <- Altere para o seu usuário
      password: 'postgres',    # <- Altere para a sua senha
      host: "localhost", 
      port: 5432
    )
  rescue PG::Error => e
    puts "Erro ao conectar ao PostgreSQL: #{e.message}"
    exit
  end

  def self.create_table
    conn = connect
    # Verificando se a tabela 'estados' já existe no banco de dados
    result = conn.exec("SELECT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'estados');")
    table_exists = result.getvalue(0, 0) == 't' 
    unless table_exists
      conn.exec <<-SQL
        CREATE TABLE estados (
          id SERIAL PRIMARY KEY,
          sigla VARCHAR(2) NOT NULL UNIQUE,
          nome VARCHAR(50) NOT NULL,
          regiao VARCHAR(20)
        );
      SQL
      puts "Tabela 'estados' criada com sucesso."
    end
  ensure
    conn.close if conn
  end
end
