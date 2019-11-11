class TodosController < ApplicationController
  before_action :find_user
  before_action :authenticate, except: [:new, :create]

  def new
    @todo = @user.todos.new
  end

  def index
    @todos = @user.todos
  end

  def create
    @todo = @user.todos.new(todo_params)

    if @todo.save
      flash[:success] = "Todo is Created Successfully!"
      redirect_to user_todo_path(@user, @todo)
    else
      render 'new'
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update_attributes(todo_params)
      flash[:success] = "Todo is Updated Successfully!"
      redirect_to user_todo_path(@user, @todo)
    else
      render 'edit'
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def destroy
    redirect_to root_url unless current_user?(@user)
    Todo.find(params[:id]).destroy
    flash[:dark] = "Advertisement has been deleted Sucessfully!"
    redirect_to root_url
  end

  private
  def todo_params
    params.require(:todo).permit(:description, :schedule, :status)
  end

  # Authenticates correct user.
  def authenticate
    if logged_in_user
      redirect_to root_url unless current_user?(find_user)
    end
  end

  # Find User
  def find_user
    @user = User.find(params[:user_id])
  end

end
