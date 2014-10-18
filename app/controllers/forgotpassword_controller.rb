=begin 
  Forgot password controller
=end
class ForgotpasswordController < ApplicationController
  layout false
  
  #### Display forgot password form starts here ####
  
  def index
    
    if params[:email]
    if User.where('email = ?', params[:email]).count == 0
      flash[:error] = "Email not found"
      redirect_to "/forgotpassword"
    else
      len = 16
      ustring=rand(36**len).to_s(36)
      while User.where('resetPasswordToken = ?', ustring).count != 0
        ustring=rand(36**len).to_s(36)
      end
      ForgotMailer.forgotpassword_email(params[:email],ustring).deliver
       #@user = User.where(email: params[:email])
       toupdate=Array.new
       toupdate={"resetPasswordToken"=>ustring}
      User.where("`users`.`email` = '#{params[:email]}'").update_all(:resetPasswordToken => ustring)
      flash[:notice]=" You will receive an email with instructions about how to reset your password in a few minutes. "
      redirect_to "/login"
    end
    end
  end
  #### Display forgot password form ends here ####
  
  #### Update reset password code starts here ####
  
  def new
    @user = User.new
    @userflds=User.where('resetPasswordToken = ?', params[:reset_password_token])
    if params[:id]
      @user = User.find(params[:id])
     if @user.update_attributes(params)
     flash[:notice]=" Your password has been changed ! Please login to tagaly using newly created password. "
       redirect_to "/login"
     end
    end
  end
  
  #### Update reset password code ends here ####
end
