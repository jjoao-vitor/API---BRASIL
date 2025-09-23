# API---BRASIL

Projeto em Ruby que consome a API do Brasil para importar e consultar dados públicos do país (ex: estados, cidades, indicadores).

# Funcionalidades

- Importar dados da API do Brasil para o banco de dados.
- Listar registros cadastrados no banco.
- Buscar registros por nome ou outro critério disponível na API.
- Limpar todos os dados do banco (reimportar do zero).

## Estrutura do Projeto

api-brasil-ruby/
- app.rb # Regras de negócio (importar e buscar dados)
- brasil_api.rb # Consumo da API do Brasil
- database.rb # Conexão e consultas ao PostgreSQL
- main.rb # Menu interativo (entrada do sistema)
- Gemfile # Dependências Ruby
