get '/' do
  redirect '/questions'
end

get '/error' do
  erb :"error"
end
