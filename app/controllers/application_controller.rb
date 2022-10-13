class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #railsのすべてのコントローラで使えるようになる
  before_action :login_required

  private 

  def login_required
    redirect_to new_session_path unless current_user #current_userがnilの時、値がない時
  end
end
