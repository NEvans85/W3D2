require_relative "questions_db_manager.rb"

class Question

  def self.find_by_id(id)
    result = QuestionsDBManager.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    Question.new(result.first)
  end

  def self.find_by_author(fname, lname)
    results = QuestionsDBManager.instance.execute(<<-SQL, fname, lname)
      SELECT
        questions.*
      FROM
        questions
        JOIN users
          ON questions.author_id = users.id
      WHERE
        users.fname = ? AND
        users.lname = ?
    SQL
    results.map { |entry| Question.new(entry) }
  end

  def self.all
    entries = QuestionsDBManager.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      questions
    SQL

    entries.map { |entry| Question.new(entry) }
  end

  attr_accessor :id, :title, :body, :author_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
end
