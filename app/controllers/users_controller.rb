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
      sign_in @user
      redirect_to questions_path
    else
      render 'new'
    end
  end

  def profile 
  	@user = current_user
  	@questions = Question.where(user_id: @user.id).last('5').reverse
  	@answers = Answer.where(user_id: @user.id).last('5').reverse
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end
