class QuestionsController < ApplicationController
  
  before_action :authenticate, only: [:new, :rate_up, :rate_down]

  def index
    @answers = Answer.all 
    @views   = View.all
    @tags    = Tag.joins(:question_tags).all.distinct

    if params[:search]
      @questions =Question.search(params[:search])
    elsif params[:tag]
      tag = Tag.find_by(name: params[:tag])
      @questions = Question.joins(:question_tags).where(:question_tags => {:tag_id => tag.id})
    else
      @questions = Question.last('10').reverse 
    end
  end 


  def new 
  @question = Question.new
  @tag      = Tag.new
  end

  def create 
    user      = current_user

    @question = Question.new(question_params)
    @question.code = params[:code]
    @question.user_id = user.id
    @question.save! 

    tags = (params[:tags]).gsub(/[ ]/, ',').split(',').reject(&:empty?).each {|tag| tag.downcase!}
    tags.each do |tag|
      double_tag = Tag.where(name: tag).first
      
      if double_tag == nil
        tag = Tag.new(name: tag) 
        tag.save! if tag.valid? 
      else
        tag = double_tag
      end
      QuestionTag.create(question_id: user.id, tag_id: tag.id)
    end

    redirect_to root_path
  end

  def show
    @question = Question.find(params[:id])
    @answers  = Answer.where(question_id: @question.id).last(5).reverse
    @comments = Comment.where(question_id: @question.id)
    @users    = User.all
    star      = Star.find_by(question_id: params[:id])
    if star != nil
      @star = star.answer_id 
      @answer_with_star = Answer.find(@star)
    end

    if current_user != nil
      view = View.new(user_id: current_user.id, question_id: @question.id)
      view.save! if View.find_by(user_id: current_user, question_id: @question.id) == nil
    else
      @current_user = nil
    end
  end

  def edit
    @question = Question.find_by(:id)
  end 

  def make_a_star 
    question = Question.find(params[:quest])
    answer   = Answer.find(params[:ans])
    star     = Star.new(user_id: question.user_id, question_id: question.id, answer_id: answer.id)
    star.save! if star.valid? and star.user_id == current_user.id

    redirect_to question_path(question.id)
  end


  private

  def question_params
    params.require(:question).permit(:description, :title)
  end 


end
