class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def login
    user = User.find_by(email: login_params[:email])

    if user.present? && user.password.eql?(login_params[:password])
      render status: 200, json: { message: "Sucesso!", id: user.id } and return
    end

    render status: 401, json: error
  end

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def success
    { message: "Sucesso!" }
  end

  def error
    { message: "Falha na autenticação." }
  end

  def set_user
    @user = User.find(params[:id])
  end

  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
