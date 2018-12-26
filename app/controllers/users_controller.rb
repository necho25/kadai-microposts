class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーの新規登録が出来ました'
      redirect_to @user
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end