class TodoListsController < ApplicationController
  def index
    @todo_lists = current_user.todo_lists
  end

  def create
    @todo_list = current_user.todo_lists.create(todo_list_params)
    redirect_to @todo_list
  end

  def show
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  def new
    @todo_list = TodoList.new
  end

  def destroy
    @todo_list = current_user.todo_lists.find(params[:id])
    @todo_list.destroy
    redirect_to todo_lists_url, notice: "Todo list was successfully deleted."
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end
end
