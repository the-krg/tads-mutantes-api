class PowersController < ApplicationController
  before_action :set_power, only: [:show, :update, :destroy]

  def index
    @powers = Power.all

    render json: @powers
  end

  def show
    render json: @power
  end

  def mutants_by_power
    power = Power.where('name ilike ?', "%#{params[:power]}%").first

    if power.present?
      render json: power.mutants, adapter: :json, each_serializer: OnlyMutantSerializer
    else
      render json: { 'message': 'não achei' }, status: :not_found
    end
  end

  def mutants
    mutants = Power.find(params[:power_id]).mutants

    render json: mutants
  end

  def create
    @power = Power.new(power_params)

    if @power.save
      render json: @power, status: :created, location: @power
    else
      render json: @power.errors, status: :unprocessable_entity
    end
  end

  def update
    if @power.update(power_params)
      render json: @power
    else
      render json: @power.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @power.destroy
  end

  private

  def set_power
    @power = Power.find(params[:id])
  end

  def power_params
    params.require(:power).permit(:name, :description)
  end
end
