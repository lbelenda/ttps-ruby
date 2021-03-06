class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @books = current_user.books.paginate(page: params[:page], per_page: 10)
  end

  # GET /books/1
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = @book.export_pdf
        send_data pdf.render, filename: "export_#{@book.name}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /books/new
  def new
    @book = current_user.books.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)

    if @book.save
      redirect_to books_path, notice: 'Libro creado exitosamente'
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Libro modificado exitosamente'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Libro eliminado'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = current_user.books.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name)
    end
end
