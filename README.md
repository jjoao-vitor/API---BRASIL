# API-BRASIL

Projeto em Ruby que consome a API do Brasil para importar e consultar dados públicos do país (ex: estados, cidades, indicadores).

# Funcionalidades

- Importar dados da API do Brasil para o banco de dados.
- Listar registros cadastrados no banco.
- Buscar registros por nome ou outro critério disponível na API.
- Limpar todos os dados do banco (reimportar do zero).

## Estrutura do Projeto
```
api-brasil-ruby/
│── meu_app.rb                # Regras de negócio (importar e buscar dados)
│── brasil_api_service.rb     # Consumo da API do Brasil
│── database.rb               # Conexão e consultas ao PostgreSQL
│── main.rb                   # Menu interativo (entrada para pesquisa no sistema)
│── Gemfile                   # Dependências Ruby
```
# Criação do Banco e da Tabela

1. Criando o banco de dados no PostgreSQL:
```
CREATE DATABASE brasil_api_app;
```

# O código database.rb já cria a tabela automaticamente ao inicializar (Caso ela não exista no banco).
```
CREATE TABLE IF NOT EXISTS estados (
  id SERIAL PRIMARY KEY,
  sigla VARCHAR(2) NOT NULL UNIQUE,
  nome VARCHAR(50) NOT NULL,
  regiao VARCHAR(20)
);
```

# Dependências do Projeto
- pg: conexão e interação com o banco de dados PostgreSQL.
- httparty: requisições HTTP.
- json: manipulação de JSON.
