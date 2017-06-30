get '/' do
  redirect '/questions'
end

get '/404' do
  erb :"404"
end
