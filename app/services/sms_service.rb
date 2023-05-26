require 'twilio-ruby'

class SmsService
  def initialize
    @client = Twilio::REST::Client.new(
      Rails.configuration.twilio_account_sid,
      Rails.configuration.twilio_auth_token
    )
  end

  def enviar_sms(numero, mensagem)
    @client.messages.create(
      from: '+13159096538',
      to: "+#{numero}",
      body: mensagem
    )
  end
end
