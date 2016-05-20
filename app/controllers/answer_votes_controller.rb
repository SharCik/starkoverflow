class AnswerVotesController < ApplicationController
  before_action :authenticate, only: :create

  def create
    @answer = Answer.find(params[:ans])
    user    = current_user
    if AnswerVote.where(answer_id: @answer.id, user_id: user.id).empty?
      @vote = AnswerVote.new(user_id: user.id, answer_id: @answer.id, direction: params[:direct])
      save_vote
    elsif AnswerVote.find_by(answer_id: @answer.id,user_id: user.id).direction.to_s != params[:direct].to_s and AnswerVote.all.where(answer_id: @answer.id,user_id: user.id).count != 2
      @vote = AnswerVote.new(user_id: user.id, answer_id: @answer.id, direction: params[:direct])
      save_vote
    end

    redirect_to question_path(params[:quest])
  end

  private

    def save_vote
      if @vote.valid?
        @vote.save!
        @answer.count += 1
        @answer.save!
      end 
    end
end
