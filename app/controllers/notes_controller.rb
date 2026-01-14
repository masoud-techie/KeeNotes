class NotesController < ApplicationController
  # Devise helper: require login
  before_action :authenticate_user!
  before_action :set_note, only: [:edit, :update]
  before_action :redirect_if_deleted, only: [:edit, :update]


  # Only run set_note for actions that need an ID
  before_action :set_note, only: [:show, :edit, :update, :destroy, :toggle_favorite, :archive, :unarchive]

  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def authorize_owner!
    redirect_to notes_path, alert: "Not authorized." unless @note.user == current_user
  end

  def index
    @notes = Note
               .active
               .left_joins(:note_shares)
               .where(
                 "notes.user_id = :user_id OR note_shares.user_id = :user_id",
                 user_id: current_user.id
               )
               .distinct
               .order(created_at: :desc)
  end

  def archived
    @archived_notes = current_user.notes.archived
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
    note = current_user.notes.find(params[:id])
    note.soft_delete
    redirect_to notes_path, notice: "Note moved to Recycle Bin."
  end


  def note_params
    params.require(:note).permit(:title, :description, :favorite)
  end

  def toggle_favorite
    @note = current_user.notes.find(params[:id])
    @note.update(favorite: !@note.favorite)

    redirect_back fallback_location: notes_path
  end

  def archive
    note = current_user.notes.find(params[:id])
    note.update!(archived: true)
    redirect_to notes_path, notice: "Note archived"
  end

  def unarchive
    note = current_user.notes.find(params[:id])
    note.update!(archived: false)
    redirect_to archived_notes_path, notice: "Note restored"
  end

  def recycle_bin
    @notes = current_user.notes
                         .merge(Note.deleted)
                         .order(deleted_at: :desc)
  end


  def restore
    note = current_user.notes.deleted.find(params[:id])
    note.restore
    redirect_to recycle_bin_notes_path, notice: "Note restored successfully."
  end

  def destroy_permanently
    note = current_user.notes.deleted.find(params[:id])
    note.destroy
    redirect_to recycle_bin_notes_path, alert: "Note permanently deleted."
  end


  def set_note
    @note = current_user.notes
                        .unscope(where: :deleted_at)
                        .find_by(id: params[:id])
  end

  def redirect_if_deleted
    return unless @note
    redirect_to notes_path, alert: "You cannot edit a deleted note." if @note.deleted?
  end

  def empty_recycle_bin
    notes = current_user.notes.deleted

    if notes.exists?
      notes.destroy_all
      redirect_to recycle_bin_notes_path, alert: "Recycle Bin emptied."
    else
      redirect_to recycle_bin_notes_path, notice: "Recycle Bin is already empty."
    end
  end

  private

  # Only allow the current user's note
  def set_note
    @note = current_user.notes.find_by(id: params[:id]) ||
            current_user.shared_notes.find(params[:id])
  end

  def visible_notes(scope)
    scope
      .left_joins(:note_shares)
      .where(
        "notes.user_id = :user_id OR note_shares.user_id = :user_id",
        user_id: current_user.id
      )
      .distinct
      .order(created_at: :desc)
  end
end
