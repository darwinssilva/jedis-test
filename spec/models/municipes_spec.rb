require 'rails_helper'

RSpec.describe Municipe, type: :model do
  describe 'validations' do
    it 'requires presence of required fields' do
      municipe = Municipe.new

      expect(municipe).to_not be_valid
      expect(municipe.errors[:nome_completo]).to include("can't be blank")
      expect(municipe.errors[:cpf]).to include("can't be blank")
      expect(municipe.errors[:cns]).to include("can't be blank")
      expect(municipe.errors[:email]).to include("can't be blank")
      expect(municipe.errors[:data_nascimento]).to include("can't be blank")
      expect(municipe.errors[:telefone]).to include("can't be blank")
      expect(municipe.errors[:foto]).to include("can't be blank")
      expect(municipe.errors[:status]).to include("can't be blank")
    end

    it 'validates CPF format' do
      municipe = FactoryBot.build(:municipe, cpf: '12345678900')
      expect(municipe).not_to be_valid
      expect(municipe.errors[:cpf]).to include('não é válido')
    end

    it 'validates CNS format' do
      municipe = FactoryBot.build(:municipe, cns: '123')
      expect(municipe).not_to be_valid
      expect(municipe.errors[:cns]).to include('formato inválido')
    end

    it 'validates email format' do
      municipe = FactoryBot.build(:municipe, email: 'invalid_email')
      expect(municipe).not_to be_valid
      expect(municipe.errors[:email]).to include('inválido')
    end

    it 'validates data_nascimento' do
      municipe = FactoryBot.build(:municipe, data_nascimento: Date.tomorrow)
      expect(municipe).not_to be_valid
      expect(municipe.errors[:data_nascimento]).to include('não pode ser uma data futura')

      municipe = FactoryBot.build(:municipe, data_nascimento: Date.new(1800, 1, 1))
      expect(municipe).not_to be_valid
      expect(municipe.errors[:data_nascimento]).to include('inválida')
    end
  end

  describe 'callbacks' do
    let(:municipe) { FactoryBot.build(:municipe) }

    before do
      allow(MunicipeMailer).to receive(:cadastro_email).and_return(double('MunicipeMailer', deliver_now: true))
      allow_any_instance_of(SmsService).to receive(:enviar_sms)
    end

    it 'sends email and SMS after create' do
      expect(MunicipeMailer).to receive(:cadastro_email).with(municipe)
      expect_any_instance_of(SmsService).to receive(:enviar_sms).with(municipe.telefone, 'Cadastro realizado com sucesso!')
      municipe.save
    end

    it 'does not send email and SMS after update if status not changed' do
      municipe.save
      expect(MunicipeMailer).not_to receive(:cadastro_email)
      expect_any_instance_of(SmsService).not_to receive(:enviar_sms)
      municipe.update(nome_completo: 'John Doe')
    end
  end
end
