require_relative "questions_db_manager.rb"

class QuestionFollow

  def self.find_by_user_id(user_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        user_id = ?
    SQL
    results.map { |entry| QuestionFollow.new(entry) }
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_id = ?
    SQL
    results.map { |entry| QuestionFollow.new(entry) }
  end

  def initialize(options)
    @id = options['id']
    @author_id = options['author_id']
    @question_id = options['question_id']
  end

end
