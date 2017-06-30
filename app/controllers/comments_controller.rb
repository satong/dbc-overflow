get '/comments/:id/edit' do
  @comment = Comment.find(params[:id])
  redirect "#{@comment.get_redirect_route}" unless authorized_user?(@comment)
  erb :'comments/edit'
end

put '/comments/:id' do
  comment = Comment.find(params[:id])
  redirect "#{comment.get_redirect_route}" unless authorized_user?(comment)
  comment.update_attributes(body: params[:body])
  redirect "#{comment.get_redirect_route}"
end

delete '/comments/:id' do
  comment = Comment.find(params[:id])
  redirect = comment.get_redirect_route
  redirect "#{redirect}" unless authorized_user?(comment)
  comment.destroy
  redirect "#{redirect}"
end
