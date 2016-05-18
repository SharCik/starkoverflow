class AnswersController < ApplicationController
	def new
		@question = Question.find(params[:question_id])
		@answer   = Answer.new
	end

	def create
		@question = Question.find(params[:question_id])
		@answer   = @question.answers.build(answer_params)
		
		if @answer.save
			redirect_to question_path(@question), notice: "Answer created successfully"
		else
			flash[:error] = "Answer not save!"

			render :new
		end
	end


	private

	def answer_params
		params.require(:answer).permit(:answer).merge(user_id: current_user.id)
	end

end
