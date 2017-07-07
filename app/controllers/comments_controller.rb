get '/comments/:id/edit' do
  @comment = Comment.find(params[:id])
  redirect "#{@comment.get_redirect_route}" unless authorized_user?(@comment)
  if request.xhr?
    erb :'_edit', layout: false, locals: {object: @comment}
  else
    erb :'comments/edit'
  end
end

put '/comments/:id' do
  @comment = Comment.find(params[:id])
  redirect "#{@comment.get_redirect_route}" unless authorized_user?(@comment)
  @comment.update_attributes(body: params[:body])
  if request.xhr?
    content_type :json
    {body: @comment.body}.to_json
  else
    redirect "#{@comment.get_redirect_route}"
  end
end

delete '/comments/:id' do
  @comment = Comment.find(params[:id])
  @redirect_url = @comment.get_redirect_route
  redirect "#{@redirect_url}" unless authorized_user?(@comment)
  @comment.destroy
  redirect "#{@redirect_url}" if !request.xhr?
end
