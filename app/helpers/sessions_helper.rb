module SessionsHelper

def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end

def logged_in? 
  current_user.present?  
    #if !current_user redirect_to new_user_path, flash.now[:danger] = "Vous n'avez pas le droit d'accéder à cette page"
    #end     
end

def only_signed_out
  redirect_to user_path(current_user.id) if logged_in?
end
end
