class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'Cadastro realizado com sucesso!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :location, :email, :password, :password_confirmation, :bio)
  end
end
