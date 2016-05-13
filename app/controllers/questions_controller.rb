class QuestionsController < ApplicationController
  @@questions_with_rate ||= []
  
  before_action :authenticate, only: [:new, :rate_up, :rate_down]

  def index
    @answers = Answer.all 
    if params[:search]
      @questions =Question.search(params[:search])

    else
      @questions = Question.last('10').reverse 
    end

  end 

  def new 
  @question = Question.new

  end

  def create 
    user = current_user
    @question = Question.new(question_params)
    @question.user_id = user.id
    @question.save
    redirect_to root_path
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: @question.id)
    @comments = Comment.where(question_id: @question.id)
    @users= User.all
  end

  def edit
    @question = Question.find_by(:id)
  end 

  def rate_up
    @question = Question.find(params[:quest])
    if !@@questions_with_rate.include?(@question.id)
      @question.rating = @question.rating + 1
      @question.save
      @@questions_with_rate << @question.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def rate_down
    @question = Question.find(params[:quest])
    if !@@questions_with_rate.include?(@question.id)
      @question = Question.find(params[:quest])
      @question.rating = @question.rating - 1
      @question.save
      @@questions_with_rate << @question.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


  private

  def question_params
    params.require(:question).permit(:description, :title)
  end 





end
