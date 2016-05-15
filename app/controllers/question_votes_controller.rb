class QuestionVotesController < ApplicationController
	before_action :authenticate, only: :create

  def create
  	@question = Question.find(params[:quest])
		user = current_user
		if (QuestionVote.where(question_id: @question.id, user_id: user.id).empty? or QuestionVote.find_by(question_id: @question.id,user_id: user.id).direction.to_s != params[:direct].to_s)
			@vote = QuestionVote.new
			@vote.user_id = user.id
			@vote.question_id = @question.id
			@vote.direction = params[:direct]
			@vote.save! if @vote.valid?
		end

		redirect_to questions_path
  end


end