class NotesController < ApplicationController
  # Devise helper: require login
  before_action :authenticate_user!

  # Only run set_note for actions that need an ID
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # List all notes for current user
  def index
    @notes = current_user.notes
  end

  # Show favorite notes only
  def favorites
    # This will never be nil; safe even if no favorites exist
    @notes = current_user.notes.where(favorite: true)
  end

  # Show single note
  def show
  end

  # New note form
  def new
    @note = current_user.notes.build
  end

  # Create note
  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to notes_path, notice: "Note created successfully."
    else
      render :new
    end
  end

  # Edit note form
  def edit
  end

  # Update note
  def update
    if @note.update(note_params)
      redirect_to notes_path, notice: "Note updated successfully."
    else
      render :edit
    end
  end

  # Delete note
  def destroy
    @note.destroy
    redirect_to notes_path, notice: "Note deleted."
  end

  private

  # Only allow the current user's note
  def set_note
    @note = current_user.notes.find(params[:id])
  end

  # Strong params
  def note_params
    params.require(:note).permit(:title, :description, :favorite)
  end
end
