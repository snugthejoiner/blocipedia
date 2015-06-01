class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    if @wiki.save
      flash[:notice] = "Wiki was created."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki."
      render :new
    end
  end
  
  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the wiki."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "The wiki \"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

end
