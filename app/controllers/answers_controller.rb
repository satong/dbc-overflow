get '/answers/:id/edit' do
  @answer = Answer.find(params[:id])
  redirect "#{@answer.get_redirect_route}" unless authorized_user?(@answer)
  erb :'answers/edit'
end

put '/answers/:id' do
  answer = Answer.find(params[:id])
  redirect "#{answer.get_redirect_route}" unless authorized_user?(answer)
  answer.update_attributes(body: params[:body])
  redirect "#{answer.get_redirect_route}"
end

delete '/answers/:id' do
  answer = Answer.find(params[:id])
  redirect "#{answer.get_redirect_route}" unless authorized_user?(answer)
  question =  answer.question.id
  answer.destroy
  redirect "/questions/#{question}"
end
