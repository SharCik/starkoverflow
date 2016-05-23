class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #include SessionsHelper

  helper_method :signed_in?, :current_user, :count_rate_answer, :create_tag

  private


  def count_rate_answer(id)
    @answer = Answer.find(id)
    AnswerVote.all.where(answer_id: @answer.id, direction: true).size - AnswerVote.all.where(answer_id: @answer.id, direction: false).size 
  end

  def login(user)
  	session[:user_id] = user.id
  end

  def authenticate
  	redirect_to signin_path if !signed_in?
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

  def create_tag(params)
    tags = (params).gsub(/[ ]/, ',').split(',').reject(&:empty?).each {|tag| tag.downcase!}
    tags.each do |tag|
    double_tag = Tag.where(name: tag).first
      
      if double_tag == nil
        tag = Tag.new(name: tag) 
        tag.save! if tag.valid? 
      else
        tag = double_tag
      end
      UserTag.create(user_id: @user.id, tag_id: tag.id)
    end
  end

end
