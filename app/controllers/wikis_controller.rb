class WikisController < ApplicationController
  def index
    # if user_signed_in?
      @wikis = policy_scope(Wiki)
    # else
     # redirect_to root_path
    # end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.build(params.require(:wiki).permit(:title, :body, :private))
    authorize @wiki
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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
