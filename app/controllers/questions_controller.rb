get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/new' do
  redirect '/login' unless logged_in?
  erb :'questions/new'
end


get '/questions/:id' do
  @question = Question.find(params[:id])
  erb :'questions/show'
end
