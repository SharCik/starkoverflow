module QuestionsHelper

  def count_questions_with_tag(tag)
    Question.joins(:question_tags).where(:question_tags => {:tag_id => tag.id}).count
  end

  def count_rate(id)
    @question = Question.find(id)
    count = QuestionVote.all.where(question_id: @question.id, direction: true).size - QuestionVote.all.where(question_id: @question.id, direction: false).size
  end

end
