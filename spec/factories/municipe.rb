require 'faker'

FactoryBot.define do
  factory :municipe do
    nome_completo { "John Doe" }
    cpf { CPF.generate }
    cns { Faker::Number.number(digits: 15) }
    email { Faker::Internet.email }
    data_nascimento { Date.today }
    telefone { "5511983238356" }
    foto { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'example.jpg'), 'image/jpeg') }
    status { true }

    after(:create) do |municipe|
      municipe.endereco = FactoryBot.create(:endereco, municipe_id: municipe.id)
    end

    trait :inativo do
      status { false }
    end

    factory :municipe_inativo, traits: [:inativo]
  end
end
