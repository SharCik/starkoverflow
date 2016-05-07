class QuestionsController < ApplicationController
	
	def index
		@questions =  Question.all 
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
	end

	def edit
		@question = Question.find_by(:id)
	end 

	def rate_up
		@question = Question.find_by(params[:id])
		@question.rating = @question.rating + 1
		@question.save
		redirect_to root_path
	end

	def rate_down
		@question = Question.find_by(params[:id])
		@question.rating = @question.rating - 1
		@question.save
		redirect_to root_path
	end


	private

	def question_params
		params.require(:question).permit(:description, :title)
	end 



end
