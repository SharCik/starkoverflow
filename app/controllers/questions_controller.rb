class QuestionsController < ApplicationController
  
  before_action :authenticate, only: [:new, :rate_up, :rate_down]

  def index
    @answers = Answer.all 
    @views = View.all
    @tags = Tag.all
    if params[:search]
      @questions =Question.search(params[:search])
    elsif params[:tag]
      tag = Tag.find_by(name: params[:tag])
      @questions =Question.joins(:question_tags).where(:question_tags => {:tag_id => tag.id})
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
    @question.user_id = user.id
    @question.save! 

    tags = (params[:tags]).sub(/[ ]/, ',').split(',').reject(&:empty?)
    tags.each do |tag|
      tag = Tag.new(name: tag)
      tag.save! if tag.valid? 
      q = QuestionTag.create(question_id: @question.id, tag_id: tag.id)
    end

    redirect_to root_path
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: @question.id)
    @comments = Comment.where(question_id: @question.id)
    @users= User.all
    stars = Star.all
    s = []
    stars.each {|st| s << st.id}
    if s.include?(@question.id)
      @star = Star.find(@question.id) 
      @star = @star.answer_id
    end
    view = View.new(user_id: current_user.id, question_id: @question.id)
    view.save! if view.valid?
  end

  def edit
    @question = Question.find_by(:id)
  end 

  def make_a_star 
    question = Question.find(params[:quest])
    answer = Answer.find(params[:ans])
    star = Star.new(user_id: question.user_id, question_id: question.id, answer_id: answer.id)
    star.save! if star.valid? and star.user_id == current_user.id

    redirect_to question_path(question.id)
  end


  private

  def question_params
    params.require(:question).permit(:description, :title)
  end 





end
