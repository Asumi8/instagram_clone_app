class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase) #ログイン画面で入力されたemailを取得 
    if user && user.authenticate(params[:session][:password])#emailとパスワードが一致していたら
      session[:user_id] = user.id #セッションにユーザーIDを登録する
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end
end
