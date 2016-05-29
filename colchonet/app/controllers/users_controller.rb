class UsersController < ApplicationController
  before_action :user, only: [:show, :edit, :update]
  before_filter :require_no_authentication, only: [:new, :create]
  before_filter :can_change, only: [:edit, :update]

  def new
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      SignupMailer.confirm_email(@user).deliver
      redirect_to @user, notice: 'Cadastro realizado com sucesso!'
    else
      render :new
    end
  end

  # GET /users/1/edit
  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Dados atualizado com sucesso!' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def can_change
    unless user_signed_in? && current_user == user
      redirect_to user_path(params[:id])
    end
  end

  def user_params
    params.require(:user).permit(:full_name, :location, :email, :password, :password_confirmation, :bio)
  end
end
