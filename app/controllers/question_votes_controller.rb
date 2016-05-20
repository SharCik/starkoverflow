class QuestionVotesController < ApplicationController
	before_action :authenticate, only: :create

  def create
  	@question = Question.find(params[:quest])
		user = current_user
		if QuestionVote.where(question_id: @question.id, user_id: user.id).empty?
  		@vote = QuestionVote.new(user_id: user.id, question_id: @question.id, direction: params[:direct])
			save_vote
		elsif QuestionVote.find_by(question_id: @question.id,user_id: user.id).direction.to_s != params[:direct].to_s and QuestionVote.all.where(question_id: @question.id,user_id: user.id).count != 2
  		@vote = QuestionVote.new(user_id: user.id, question_id: @question.id, direction: params[:direct])
			save_vote
		end

		redirect_to questions_path
  end


  private

  	def save_vote
  		if @vote.valid?
        @vote.save!
        @question.count += 1
        @question.save!
      end 
  	end
end

