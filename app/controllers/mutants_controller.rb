class MutantsController < ApplicationController
  before_action :set_mutant, only: [:show, :update, :destroy]

  # GET /mutants
  def index
    @mutants = Mutant.all

    render json: @mutants, adapter: :json
  end

  # GET /mutants/1
  def show
    render json: @mutant
  end

  # POST /mutants
  def create
    @mutant = Mutant.new(mutant_params)
    @mutant.user_id = params[:user_id]

    File.open("storage/#{mutant_params[:name]}_image.jpg", 'wb') do |f|
      f.write(Base64.decode64(params[:image]))
    end

    @mutant.photo.attach(io: File.open("storage/#{mutant_params[:name]}_image.jpg"), filename: "#{mutant_params[:name]}_image.jpg")

    params[:powers].each do |power|
      power = Power.find_or_create_by(name: power)

      @mutant.powers << power
    end

    if @mutant.save
      render json: { 'message': 'Sucesso!' }.to_json, status: :created
    else
      puts @mutant.errors.messages
      render json: { 'message': @mutant.errors }.to_json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mutants/1
  def update
    if params[:image].present?
      File.open("storage/#{mutant_params[:name]}_image.jpg", 'wb') do |f|
        f.write(Base64.decode64(params[:image]))
      end

      @mutant.photo.attach(io: File.open("storage/#{mutant_params[:name]}_image.jpg"), filename: "#{mutant_params[:name]}_image.jpg")
    end

    arr = []

    params[:powers].each do |power|
      power = Power.find_or_create_by(name: power)

      arr << power
    end

    @mutant.powers = arr

    if @mutant.update(mutant_params)
      render json: @mutant
    else
      render json: @mutant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mutants/1
  def destroy
    @mutant.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mutant
      @mutant = Mutant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mutant_params
      params.require(:mutant).permit(:name)
    end
end
