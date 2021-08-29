class SessionsController < ApplicationController
 
  skip_before_action :login_required, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]
  
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Connexion réussie'
      redirect_to user_path(user.id)

      else
        flash[:danger] = 'Identifiants incorrects'
        render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
    flash[:notice] = 'Déconnexion réussie'
  end
end
