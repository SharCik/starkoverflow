class CommentsController < ApplicationController
  @@question ||= nil

  def new
	if signed_in?
		@question = Question.find(params[:quest])
		@@question = @question.id
		@comment = Comment.new
	else
		flash[:alert] = "Sign in,please!"
		redirect_to question_path(@@question)
	end
  end

  def create
	user = current_user
	@comment = Comment.new(comment_params)
	@comment.user_id = user.id
	@comment.question_id = @@question
	@comment.save!
	redirect_to question_path(@@question)
  end

  private 

  	def comment_params 
  		params.require(:comment).permit(:text)
  	end
end
