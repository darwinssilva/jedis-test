class Endereco < ApplicationRecord
  belongs_to :municipe

  validates :cep, :logradouro, :bairro, :cidade, :uf, presence: true
  validates :codigo_ibge, allow_blank: true, length: { maximum: 10 }
end