class QuestionsController < ApplicationController
	
	def index
		@questions =  Question.last('10').reverse
	end 

	def new 
		if signed_in?
			@question = Question.new
		else
			flash[:alert] = "Sign in,please!"
			redirect_to root_path
		end
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
		@users= User.all
	end

	def edit
		@question = Question.find_by(:id)
	end 

	def rate_up
		if signed_in?
			@question = Question.find(params[:quest])
			@question.rating = @question.rating + 1
			@question.save
			redirect_to root_path
		else
			flash[:alert] = "Sign in,please!"
			redirect_to root_path
		end
	end

	def rate_down
		if signed_in?
			@question = Question.find(params[:quest])
			@question.rating = @question.rating - 1
			@question.save
			redirect_to root_path
		else
			flash[:alert] = "Sign in,please!"
			redirect_to root_path
		end
	end


	private

	def question_params
		params.require(:question).permit(:description, :title)
	end 



end
