# app/models/municipe.rb
class Municipe < ApplicationRecord
  has_one :endereco

  validates :nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, presence: true
  validates :cpf, :cns, :email, uniqueness: true
  validates :cpf, format: { with: /\A\d{11}\z/, message: 'deve conter apenas números e ter 11 dígitos' }
  # Outras validações

  after_create :send_email_and_sms
  after_update :send_email_and_sms, if: :status_changed?

  private

  def send_email_and_sms
    # Lógica para enviar o email e o SMS
  end
end

# app/models/endereco.rb
class Endereco < ApplicationRecord
  belongs_to :municipe

  validates :cep, :logradouro, :bairro, :cidade, :uf, presence: true
  # Outras validações
end
