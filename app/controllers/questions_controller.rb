class QuestionsController < ApplicationController
  
  before_action :authenticate, only: [:new, :rate_up, :rate_down]

  def index
    @answers = Answer.all 
    @views = View.all
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
    view = View.new(user_id: current_user.id, question_id: @question.id)
    view.save! if view.valid?
  end

  def edit
    @question = Question.find_by(:id)
  end 



  private

  def question_params
    params.require(:question).permit(:description, :title)
  end 





end
