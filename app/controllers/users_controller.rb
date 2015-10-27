class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params_users)
    if verify_recaptcha(:User => @user, :message => "Oh shit men!") && @user.save
      begin
        ConfirmationMailer.confirm_email("#{@user.email}", @user.activation_token).deliver
        rescue
          flash[:notice] = "Activation instruction fails send your email"
        end
        flash[:notice] = "Activation instruction has send to #{@user.email}"
        redirect_to root_url
      else
        flash[:error] = "data not valid"
        render action: 'new'
      end
  end

  private
  def params_users
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :humanizer_answer, :humanizer_question_id)
  end
end
