class AnswersController < ApplicationController

	def new
		@question = Question.find_by(params[:id])
		@answer = Answer.new
	end

	def create
		user = current_user
		@question = Question.find_by(params[:id])
		@answer = Answer.new(answer_params)
		@answer.question_id = @question.id
		@answer.user_id = user.id
		@answer.save!
		redirect_to question_path(@question)
	end


	private

	def answer_params
		params.require(:answer).permit(:answer)
	end
end
