class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.find(params[:comment_id])

    @like = @comment.likes.find_or_initialize_by(user: current_user)
    @like.reaction_type = params[:reaction_type]

    if @like.save
      respond_to do |format|
        format.js # create.js.erb
      end
    else
      Rails.logger.info "LIKE SAVE FAILED: #{@like.errors.full_messages}"
      head :unprocessable_entity
    end
  end
  
  def destroy
    @place = Place.find(params[:place_id])
    @comment = @place.comments.find(params[:comment_id])

    @like = @comment.likes.find_or_initialize_by(user: current_user)
    @like.destroy if @like

    respond_to do |format|
      format.js # destroy.js.erb
    end
  end
end
