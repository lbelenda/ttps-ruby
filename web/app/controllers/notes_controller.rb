class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :export , :destroy]
  before_action :set_book, except:  [:destroy, :export]

  # GET /notes
  def index
    @notes = @book.notes.paginate(page: params[:page], per_page: 10)
  end

  # GET /notes/1
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = @note.export_pdf
        send_data pdf.render, filename: "export_#{@note.title}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /notes/new
  def new
    @books = Book.all
    @note = @book.notes.new
  end

  # GET /notes/1/edit
  def edit
    @books = Book.all
  end

  # POST /notes
  def create
    @books = Book.all
    @note = @book.notes.new(note_params)

    if @note.save
      redirect_to book_notes_path(@book), notice: 'Note was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to book_note_path(@book, @note), notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    redirect_to book_notes_url, notice: 'Note was successfully destroyed.'
  end

  private
    def set_book
      @book = params[:book_id].present? ? (current_user.books.find(params[:book_id])) : (current_user.books.find_by(name: "Global"))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_note
      set_book
      @note = @book.notes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :body, :book_id, :user_id).merge(user_id: current_user.id)
    end
end
