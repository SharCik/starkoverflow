class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #include SessionsHelper

  helper_method :signed_in?, :current_user, :count_rate

  private


  def count_rate(id)
    @question = Question.find(id)
    QuestionVote.all.where(question_id: @question.id, direction: true).size - QuestionVote.all.where(question_id: @question.id, direction: false).size 
  end

  def login(user)
  	session[:user_id] = user.id
  end

  def authenticate
  	redirect_to root_path if !signed_in?
  end

  def signed_in?
  	current_user.present?
  end

  def current_user
  	if session[:user_id]
  	  @current_user ||= User.find(session[:user_id])
  	end
  end

  def logout
  	session[:user_id] = nil
  end
end
