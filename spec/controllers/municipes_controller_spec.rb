require 'rails_helper'

RSpec.describe MunicipesController, type: :controller do
  describe "GET index" do
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
    it "assigns a new municipe to @municipe" do
      get :new

      expect(assigns(:municipe)).to be_a_new(Municipe)
    end
  end

  describe "POST create" do
    context "with valid parameters" do
      it "creates a new municipe" do
        expect {
          post :create, params: { municipe: FactoryBot.attributes_for(:municipe) }
        }.to change(Municipe, :count).by(1)
      end

      it "redirects to the municipes index page" do
        post :create, params: { municipe: FactoryBot.attributes_for(:municipe) }

        expect(response).to redirect_to(municipes_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new municipe" do
        expect {
          post :create, params: { municipe: FactoryBot.attributes_for(:municipe, nome_completo: nil) }
        }.to_not change(Municipe, :count)
      end

      it "renders the new template" do
        post :create, params: { municipe: FactoryBot.attributes_for(:municipe, nome_completo: nil) }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested municipe to @municipe" do
      municipe = FactoryBot.create(:municipe)

      get :edit, params: { id: municipe.id }

      expect(assigns(:municipe)).to eq(municipe)
    end
  end

  describe "PUT update" do
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
    it "assigns the requested municipe to @municipe" do
      municipe = FactoryBot.create(:municipe)

      get :show, params: { id: municipe.id }

      expect(assigns(:municipe)).to eq(municipe)
    end
  end
end
