require_relative "questions_db_manager.rb"

class QuestionLike
  def self.find_by_user_id(user_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        user_id = ?
    SQL
    results.map { |entry| QuestionLike.new(entry) }
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL
    results.map { |entry| QuestionLike.new(entry) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
