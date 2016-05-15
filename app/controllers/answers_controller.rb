class AnswersController < ApplicationController
	@@question ||= nil
	def new
		if signed_in?
			@question = Question.find(params[:quest])
			@@question = @question.id
			@answer = Answer.new
		else
			flash[:alert] = "Sign in,please!"

			redirect_to root_path
		end
	end

	def create
		user = current_user
		@answer = Answer.new(answer_params)
		@answer.user_id = user.id
		@answer.question_id = @@question
		@answer.save!

		redirect_to question_path(@@question)
	end


	private

	def answer_params
		params.require(:answer).permit(:answer)
	end

end
