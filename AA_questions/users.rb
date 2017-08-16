require_relative "questions_db_manager.rb"

class User

  def self.find_by_id(id)
    user = QuestionsDBManager.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDBManager.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL
    User.new(user.first)
  end

  def self.all
    entries = QuestionsDBManager.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      users
    SQL

    entries.map { |entry| User.new(entry) }
  end

  def self.followed_questions
    results = QuestionsDBManager.instance.execute(<<-SQL)
    SELECT
      questions.*
    FROM
      questions
      JOIN question_follows
        ON questions.id = question_follows.question_id
        JOIN users
          ON question_follows.user_id = users.id
          WHERE users.id = @id
    SQL

    results.map { |entry| Question.new(entry) }
  end

  attr_accessor :fname, :lname, :id

  def initialize(options)
    @fname = options['fname']
    @lname = options['lname']
    @id = options['id']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_author_id(@id)
  end
end
