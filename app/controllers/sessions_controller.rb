class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email,password)
      flash[:success] = 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました。やり直して下さい'
    end
  end

  def destroy
    session[:user_id] =nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end


private
  def login(email,password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end