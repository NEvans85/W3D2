class Questions_DB_Manager < SQLite3::Database
  include 'singleton'

  def initialize
    super('questions.db')
    self.type_translation = true
    self.result_as_hash = true
  end
end
