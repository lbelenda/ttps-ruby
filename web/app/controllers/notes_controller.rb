class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :set_book, except:  [:destroy, :export]

  # GET /notes
  def index
    @notes = @book.notes.paginate(page: params[:page], per_page: 10)
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    #@note = Note.new
    @note = @book.notes.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
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
      @book = current_user.books.find(params[:book_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :body, :book_id, :user_id).merge(user_id: current_user.id)
    end
end
