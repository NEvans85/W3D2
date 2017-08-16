require_relative "questions_db_manager.rb"
require_relative "users.rb"
require_relative "questions.rb"

class Reply

  def self.find_by_author_id(author_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL
    results.map { |entry| Reply.new(entry) }
  end

  def self.find_by_id(id)
    results = QuestionsDBManager.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    results.map { |entry| Reply.new(entry) }
  end



  def self.find_by_question_id(question_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    results.map { |entry| Reply.new(entry) }
  end

  def self.find_by_parent_reply_id(parent_reply_id)
    results = QuestionsDBManager.instance.execute(<<-SQL, parent_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL
    results.map { |entry| Reply.new(entry) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @author_id = options['author_id']
    @parent_reply_id = options['parent_reply_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    Reply.find_by_parent_reply_id(@id)
  end


end
