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
        users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT *
            FROM users
            WHERE fname = ? AND lname = ?;
        SQL
        users.map{|user| User.new(question)}
    end


    def initialize(options)
        @id = options[id]
        @fname = options[fname]
        @lname = options[lname]
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end

    def authored_replies
        Reply.find_by_user_id(self.id)
    end

end 

class Question
   attr_accessor :id, :author_id, :body, :title
    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM questions
            WHERE id = ?;
        SQL
        Question.new(question[0])
    end

    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT *
            FROM questions
            WHERE author_id = ?;
        SQL
        questions.map{|question| Question.new(question)}
    end

    def initialize(options)
        @id = options[id]
        @author_id = options[author_id]
        @body = options[body]
        @title = options[title]
    end 

    def author
        user = User.find_by_id(self.author_id)
        user.fname + ' ' + user.lname
    end 

    def replies
        replies = Reply.find_by_question_id(self.id)
        replies.each do |ele|
            puts ele.reply
        end 
    end 

end


class Reply
    attr_accessor :id, :parent_id, :subject_id, :reply, :user_id

    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT *
            FROM replies
            WHERE user_id = ?;
        SQL
        replies.map{|reply| Reply.new(reply)}
    end

    def self.find_by_question_id(subject_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, subject_id)
            SELECT *
            FROM replies
            WHERE subject_id = ?;
        SQL
        replies.map{|reply| Reply.new(reply)}
    end

     def self.find_by_id(id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT *
            FROM replies
            WHERE id = ?;
        SQL
        Reply.new(question[0])
    end

    def initialize(options)
        @id = options[id]
        @user_id = options[id]
        @parent_id = options[parent_id]
        @subject_id = options[subject_id]
        @reply = options[reply]
    end 

    def author
        user = User.find_by_id(self.user_id)
        user.fname + ' ' + user.lname    
    end 

    def question
        question = Question.find_by_question_id(self.subject_id)
        question.title
    end 

    def parent_reply
        reply = Reply.find_by_id(self.parent_id)
        reply.reply
    end 

    def child_replies
         replies = QuestionsDatabase.instance.execute(<<-SQL, self.id)
            SELECT *
            FROM replies
            WHERE parent_id = ? 
        SQL
        replies.map {|reply| Reply.new(reply).reply} 
    end 

    
end 


