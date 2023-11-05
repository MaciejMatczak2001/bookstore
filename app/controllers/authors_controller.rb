class AuthorsController < ApplicationController
  include Available
  before_action :admin_content
  before_action :set_author, only: %i[edit update destroy]

	skip_before_action :verify_authenticity_token

	def index
		@authors = Author.all
  end

  def edit
  end

  def update
    if @author.update(author_params)
      redirect_to authors_path, notice: "Author was successfully edited"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @author.destroy
    redirect_to authors_path, notice: "Author was successfully deleted"
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end

  def set_author
    @author = Author.find(params[:id])   
  end

end
