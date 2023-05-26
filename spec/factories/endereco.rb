FactoryBot.define do
  factory :endereco do
    cep { "12345-678" }
    logradouro { "Rua Exemplo" }
    complemento { "Apartamento 123" }
    bairro { "Bairro Exemplo" }
    cidade { "Cidade Exemplo" }
    uf { "UF" }
    codigo_ibge { "1234567" }
  end
end