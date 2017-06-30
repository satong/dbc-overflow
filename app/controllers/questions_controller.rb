get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

get '/questions/new' do
  redirect '/login' unless logged_in?
  erb :'questions/new'
end

post '/questions/new' do
  Question.create({user_id: current_user.id, title: params[:title], body: params[:body]})
  redirect '/questions'
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  erb :'questions/show'
end

get '/:commentable_type/:commentable_id/comments/new' do
  erb :'comments/new'
end

post '/:commentable_type/:commentable_id/comments/new' do
  object = params[:commentable_type][0..-2].capitalize
  comment = Comment.create({body: params[:body], user_id: current_user.id, commentable_type: object, commentable_id: params[:commentable_id]})
  redirect "#{comment.commentable.get_redirect_route}"
end

post '/:votable_type/:votable_id/:direction' do
  object = params[:votable_type][0..-2].capitalize
  vote = Vote.create({direction: params[:direction], user_id: current_user.id, votable_type: object, votable_id: params[:votable_id]})
  redirect "#{vote.get_redirect_route}"
end
