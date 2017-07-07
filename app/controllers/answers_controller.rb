get '/answers/:id/edit' do
  @answer = Answer.find(params[:id])
  redirect "#{@answer.get_redirect_route}" unless authorized_user?(@answer)
  if request.xhr?
    erb :'_edit', layout: false, locals: {object: @answer}
  else
    erb :'answers/edit'
  end
end

put '/answers/:id' do
  answer = Answer.find(params[:id])
  redirect "#{answer.get_redirect_route}" unless authorized_user?(answer)
  answer.update_attributes(body: params[:body])
  if request.xhr?
    content_type :json
    {body: answer.body}.to_json
  else
    redirect "#{answer.get_redirect_route}"
  end
end

delete '/answers/:id' do
  answer = Answer.find(params[:id])
  redirect "#{answer.get_redirect_route}" unless authorized_user?(answer)
  question =  answer.question.id
  answer.destroy
  redirect "/questions/#{question}"
end
