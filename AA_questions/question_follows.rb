require_relative "questions_db_manager.rb"
require_relative "questions.rb"
require_relative "users.rb"

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

  def self.followers_for_question_id(question_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
        JOIN question_follows
        ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL

    results.map { |entry| User.new(entry) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
        JOIN question_follows
        ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

    results.map { |entry| Question.new(entry) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end
