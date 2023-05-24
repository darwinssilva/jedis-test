class MunicipeMailer < ApplicationMailer
  def cadastro_email(municipe)
    @municipe = municipe
    mail(to: @municipe.email, subject: "Cadastro realizado com sucesso")
  end
end
