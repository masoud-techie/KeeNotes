class TodoItemsController < ApplicationController
  def create
    list = current_user.todo_lists.find(params[:todo_list_id])
    list.todo_items.create(todo_item_params)
    redirect_to list
  end

  def update
    item = TodoItem.find(params[:id])
    item.update(completed: !item.completed)
    redirect_back fallback_location: root_path
  end

  def destroy
    TodoItem.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def todo_item_params
    params.require(:todo_item).permit(:title)
  end
end
