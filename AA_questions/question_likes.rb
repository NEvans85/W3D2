require_relative "questions_db_manager.rb"

class QuestionLike
  def self.find_by_author_id(author_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        author_id = ?
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
    @author_id = options['author_id']
    @question_id = options['question_id']
  end
end
