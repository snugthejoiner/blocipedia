class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "Collaborator added to \' #{@wiki.title}\'"
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator =  Collaborator.where(wiki_id: @wiki.id, user_id: params[:user_id]).first
    if @collaborator.destroy
      flash[:notice] = "Collaborator removed"
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error."
      render :show
    end
  end


end