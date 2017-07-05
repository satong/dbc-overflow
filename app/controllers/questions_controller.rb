get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/new' do
  redirect '/login' unless logged_in?
  erb :'questions/new'
end

post '/questions/new' do
  redirect '/login' unless logged_in?
  Question.create({user_id: current_user.id, title: params[:title], body: params[:body]})
  redirect '/questions'
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  erb :'questions/show'
end

get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  redirect "/questions/#{params[:id]}" unless authorized_user?(@question)
  erb :'questions/edit'
end

put '/questions/:id' do
  question = Question.find(params[:id])
  redirect "/questions/#{params[:id]}" unless authorized_user?(question)
  question.update_attributes(title: params[:title], body: params[:body])
  redirect "/questions/#{params[:id]}"
end


delete '/questions/:id' do
  question = Question.find(params[:id])
  redirect "/questions/#{params[:id]}" unless authorized_user?(question)
  question.destroy
  redirect "/questions"
end

get '/questions/:id/answers/new' do
  redirect '/login' unless logged_in?
  erb :'answers/new'
end

post '/questions/:id/answers/new' do
  redirect '/login' unless logged_in?
  answer = Answer.create({user_id: current_user.id, question_id: params[:id], body: params[:body]})
  redirect "#{answer.get_redirect_route}"
end

get '/:commentable_type/:commentable_id/comments/new' do
  redirect '/login' unless logged_in?
  erb :'comments/new'
end

post '/:commentable_type/:commentable_id/comments/new' do
  redirect '/login' unless logged_in?
  object = params[:commentable_type][0..-2].capitalize
  comment = Comment.create({body: params[:body], user_id: current_user.id, commentable_type: object, commentable_id: params[:commentable_id]})
  redirect "#{comment.commentable.get_redirect_route}"
end

post '/:votable_type/:votable_id/:direction' do
  redirect '/login' unless logged_in?
  object = params[:votable_type][0..-2].capitalize
  vote = Vote.create({direction: params[:direction], user_id: current_user.id, votable_type: object, votable_id: params[:votable_id]})
  if votable_user?(vote.votable)
    vote.save
    redirect "#{vote.get_redirect_route}"
  else
    redirect '/error'
  end
end
