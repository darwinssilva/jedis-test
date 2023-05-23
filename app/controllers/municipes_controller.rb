class MunicipesController < ApplicationController
  def index
    @municipes = Municipe.all
  end

  def new
    @municipe = Municipe.new
    @endereco = @municipe.build_endereco
  end

  def create
    @municipe = Municipe.new(municipe_params)
    if @municipe.save
      # Envie o email e SMS ao municipe aqui
      redirect_to municipes_path, notice: 'Municipe cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit
    @municipe = Municipe.find(params[:id])
    @endereco = @municipe.endereco
  end

  def update
    @municipe = Municipe.find(params[:id])
    if @municipe.update(municipe_params)
      # Envie o email e SMS ao municipe aqui
      redirect_to municipes_path, notice: 'Municipe atualizado com sucesso.'
    else
      render :edit
    end
  end

  def show
    @municipe = Municipe.find(params[:id])
  end

  private

  def municipe_params
    params.require(:municipe).permit(:nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto, :status,
                                     endereco_attributes: [:cep, :logradouro, :complemento, :bairro, :cidade, :uf, :codigo_ibge])
  end
end
