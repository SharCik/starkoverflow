class QuestionsController < ApplicationController
	
	def index
		@questions =  Question.all 
	end 

	def new 

	end

	def create 
		@question = Question.new(params(question_params))
		@question.save
		redirect_to index_path
	end

	def edit
		@question = Question.find_by(:id)
	end 


	private

	def question_params
		params(:question).permit(:description, :title)
	end 



end
