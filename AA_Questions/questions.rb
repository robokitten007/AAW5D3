require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
    attr_accessor :id, :fname, :lname
    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM users
            WHERE id = ?;
        SQL
        User.new(user[0])
    end

    def self.find_by_name(fname, lname)
        QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT *
            FROM users
            WHERE fname = ? AND lname = ?;
        SQL
    end


    def initialize(options)
        @id = options[id]
        @fname = options[fname]
        @lname = options[lname]
    end 

end 

class Question
   attr_accessor :id, :associated_author_id, :body, :title
    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM questions
            WHERE id = ?;
        SQL
        Question.new(question[0])
    end


    def initialize(options)
        @id = options[id]
        @associated_author_id = options[associated_author_id]
        @body = options[body]
        @title = options[title]
    end 


end

