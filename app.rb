require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model.rb' # 데이터베이스 관련 파일 (model)

set :bind, '0.0.0.0'

enable :sessions # 내가 앱에서 세션을 활용할거양

get '/' do
  @questions = Question.all #["첫번째 질문", "두번째 질문", ...]
  erb :index
end

get '/ask' do
  Question.create(
    :name => params["name"],
    :content => params["question"]
  )
  redirect to '/'
end

get '/signup' do
  erb :signup
end

get '/register' do
  User.create(
    :email => params["email"],
    :password => params["password"]
  )
  redirect to '/'
end

get '/admin' do
  @users = User.all
  erb :admin
end

get '/login' do
  erb :login
end

get '/login_session' do
  @message = ""
  if User.first(:email => params["email"])
    if User.first(:email => params["email"]).password == params["password"]
      session[:email] = params["email"]
      @message = "로그인이 되었습니다."
      # session = {}
      # {:email => "asdf@asdf.com"}
    else
      @message = "비번이 틀렸어요"
    end
  else
    @message = "해당하는 이메일의 유저가 없습니다."
  end
end

get '/logout' do
  session.clear
  redirect to '/'
end
# 로그인?
#
# 1. 로그인 하려고 하는 사람이 우리 회원인지 검사한다
#  - User 데이터베이스에 있는 사람인지 확인
#  - 로그인하려고 하는 사림이 제출한 email이 User DB에 있는지 확인한다.
# 2. 만약에 있으면,
#   - 비밀번호를 체크한다 == (제출된 비번 == db의 비번)
#      3. 만약에 맞으면
#         - 로그인 시킨다.
#      4. 비번이 틀리면
#         - 다시 비번을 치라고 한다.
# 3. 없으면
#   - 님 회원 아님 -> 회원가입 페이지로 보낸다.
