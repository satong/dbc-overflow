get '/login' do
  erb :'sessions/new'
end

post '/login' do
  if authenticate # helper method in session_helper.rb
    redirect "users/#{current_user.id}"
  else
    erb :'sessions/new'
  end
end

get '/logout' do
  session.delete(:user_id)
  redirect '/login'
end
