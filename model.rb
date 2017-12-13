DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/asked.db")

class Question
  include DataMapper::Resource # DataMapper 객체로 Question클래스를 만들겠다.
  property :id, Serial
  property :name, String
  property :content, Text
  property :created_at, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :password, String
  property :is_admin, Boolean, :default => false
  property :created_at, DateTime
end

DataMapper.finalize

Question.auto_upgrade!
User.auto_upgrade!
