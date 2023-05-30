require 'rails_helper'

RSpec.describe Endereco, type: :model do
  describe 'validations' do
    it 'requires presence of required fields' do
      endereco = Endereco.new

      expect(endereco).to_not be_valid
      expect(endereco.errors[:cep]).to include("can't be blank")
      expect(endereco.errors[:logradouro]).to include("can't be blank")
      expect(endereco.errors[:bairro]).to include("can't be blank")
      expect(endereco.errors[:cidade]).to include("can't be blank")
      expect(endereco.errors[:uf]).to include("can't be blank")
    end

    it 'validates maximum length of codigo_ibge' do
      endereco = Endereco.new(codigo_ibge: '12345678901')

      expect(endereco).to_not be_valid
      expect(endereco.errors[:codigo_ibge]).to include("is too long (maximum is 10 characters)")
    end
  end
end
