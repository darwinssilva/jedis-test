require 'rails_helper'
require 'webmock/rspec'

RSpec.describe MunicipesController, type: :controller do
  describe "GET index" do
    before do
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/AC89b520e2a2f004721f7ff5ddf7593a66/Messages.json')
        .to_return(status: 200, body: '', headers: {})
    end

    it "assigns all municipes to @municipes" do
      municipe1 = FactoryBot.create(:municipe)
      municipe2 = FactoryBot.create(:municipe)

      get :index

      expect(assigns(:municipes)).to match_array([municipe1, municipe2])
    end

    it "filters municipes by name if name parameter is present" do
      municipe = FactoryBot.create(:municipe, nome_completo: "John Doe")

      get :index, params: { nome: "John" }

      expect(assigns(:municipes).to_a).to eq([municipe])
    end

    it "filters municipes by city if cidade parameter is present" do
      municipe = FactoryBot.create(:municipe)

      get :index, params: { cidade: municipe.endereco.cidade }

      expect(assigns(:municipes).to_a).to eq([municipe])
    end
  end

  describe "GET new" do
    before do
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/AC89b520e2a2f004721f7ff5ddf7593a66/Messages.json')
        .to_return(status: 200, body: '', headers: {})
    end

    it "assigns a new municipe to @municipe" do
      get :new

      expect(assigns(:municipe)).to be_a_new(Municipe)
    end
  end

  context "with valid parameters" do
    before do
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/AC89b520e2a2f004721f7ff5ddf7593a66/Messages.json')
        .to_return(status: 200, body: '', headers: {})
    end

    it "creates a new municipe" do
      municipe_attributes = FactoryBot.attributes_for(:municipe)
      endereco_attributes = FactoryBot.attributes_for(:endereco)
      params = { municipe: municipe_attributes.merge(endereco_attributes) }

      expect {
        post :create, params: params
      }.to change(Municipe, :count).by(1)
    end

    it "redirects to the municipes index page" do
      municipe_attributes = FactoryBot.attributes_for(:municipe)
      endereco_attributes = FactoryBot.attributes_for(:endereco)
      params = { municipe: municipe_attributes.merge(endereco_attributes) }

      post :create, params: params

      expect(response).to redirect_to(municipes_path)
    end
  end

  context "with invalid parameters" do
    before do
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/AC89b520e2a2f004721f7ff5ddf7593a66/Messages.json')
        .to_return(status: 200, body: '', headers: {})
    end

    it "does not create a new municipe" do
      municipe_attributes = FactoryBot.attributes_for(:municipe, nome_completo: nil)
      endereco_attributes = FactoryBot.attributes_for(:endereco)
      params = { municipe: municipe_attributes.merge(endereco_attributes) }

      expect {
        post :create, params: params
      }.to_not change(Municipe, :count)
    end

    it "renders the new template" do
      municipe_attributes = FactoryBot.attributes_for(:municipe, nome_completo: nil)
      endereco_attributes = FactoryBot.attributes_for(:endereco)
      params = { municipe: municipe_attributes.merge(endereco_attributes) }

      post :create, params: params

      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    before do
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/AC89b520e2a2f004721f7ff5ddf7593a66/Messages.json')
        .to_return(status: 200, body: '', headers: {})
    end

    it "assigns the requested municipe to @municipe" do
      municipe = FactoryBot.create(:municipe)

      get :edit, params: { id: municipe.id }

      expect(assigns(:municipe)).to eq(municipe)
    end
  end

  describe "PUT update" do
    before do
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/AC89b520e2a2f004721f7ff5ddf7593a66/Messages.json')
        .to_return(status: 200, body: '', headers: {})
    end

    let(:municipe) { FactoryBot.create(:municipe) }

    context "with valid parameters" do
      it "updates the requested municipe" do
        put :update, params: { id: municipe.id, municipe: { nome_completo: "Updated Name" } }

        municipe.reload

        expect(municipe.nome_completo).to eq("Updated Name")
      end

      it "redirects to the municipes index page" do
        put :update, params: { id: municipe.id, municipe: { nome_completo: "Updated Name" } }

        expect(response).to redirect_to(municipes_path)
      end
    end

    context "with invalid parameters" do
      it "does not update the requested municipe" do
        put :update, params: { id: municipe.id, municipe: { nome_completo: nil } }

        municipe.reload

        expect(municipe.nome_completo).to_not be_nil
      end

      it "renders the edit template" do
        put :update, params: { id: municipe.id, municipe: { nome_completo: nil } }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "GET show" do
    before do
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/AC89b520e2a2f004721f7ff5ddf7593a66/Messages.json')
        .to_return(status: 200, body: '', headers: {})
    end

    it "assigns the requested municipe to @municipe" do
      municipe = FactoryBot.create(:municipe)

      get :show, params: { id: municipe.id }

      expect(assigns(:municipe)).to eq(municipe)
    end
  end
end
