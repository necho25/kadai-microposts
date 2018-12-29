class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
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
    
    def edit
#      @user = User.find(params[:id])
      @user = current_user
    end
    
    def update
      @user = current_user
      
      if @user.update(user_params)
        flash[:success] = "更新しました"
        redirect_to @user
      else
        flash[:error] = "更新できませんでした"
        render :edit
      end
    end
    
    def destroy
      #@user = User.find(params[:id])
      @user.destroy
      
      flash[:success] = 'アカウントを削除しました'
      redirect_to root_url
    end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end