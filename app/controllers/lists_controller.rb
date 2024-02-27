class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = List.all
  end

  def show
    @bookmarks = @list.bookmarks
    @bookmark = Bookmark.new

    @reviews = @list.reviews
    @review = Review.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_parms)

    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @list.update(list_parms)
      redirect_to list_path(@list)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.photo.purge
    @list.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def list_parms
    params.require(:list).permit(:name, :photo)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
