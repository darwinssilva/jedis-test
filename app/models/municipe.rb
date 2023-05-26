class Municipe < ApplicationRecord
  has_one :endereco
  accepts_nested_attributes_for :endereco
  
  validates :nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, :status, presence: true
  validates :cpf, :cns, :email, uniqueness: true
  validate :validar_cpf
  validate :validar_cns
  validate :validar_email
  validate :validar_data_nascimento

  after_create :send_email_and_sms
  after_update :send_email_and_sms, if: :status_changed?

  private

  def send_email_and_sms
    MunicipeMailer.cadastro_email(self).deliver_now
    SmsService.new.enviar_sms(self.telefone, 'Cadastro realizado com sucesso!')
  end

  def validar_cpf
    return if cpf.blank?

    cpf_valido = CPF.valid?(cpf)
    errors.add(:cpf, 'não é válido') unless cpf_valido
  end

  def validar_cns
    return if cns.blank?

    unless cns.match?(/\A\d{15}\z/)
      errors.add(:cns, 'formato inválido')
    end
  end
  def validar_email
    errors.add(:email, "inválido") unless email.match?(URI::MailTo::EMAIL_REGEXP)
  end

  def validar_data_nascimento
    if data_nascimento.present? && data_nascimento.future?
      errors.add(:data_nascimento, "não pode ser uma data futura")
    elsif data_nascimento.present? && data_nascimento.year < 1900
      errors.add(:data_nascimento, "inválida")
    end
  end
end
