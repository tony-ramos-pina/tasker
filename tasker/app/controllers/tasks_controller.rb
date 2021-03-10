class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.tasks
    #@done_tasks , @undone_tasks = [], []
    
    @done_tasks = @tasks.where(isDone: true)
    @undone_tasks = @tasks.where(isDone: false)

    @undone_tasks = @undone_tasks.order(lastEditDate: :desc)
    @done_tasks = @undone_tasks.order(lastEditDate: :desc)

  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def isDone?

    
  end

  def setAsDone
    @doneTask = current_user.tasks.find(params[:id])
    respond_to do |format|
      if @doneTask.update(isDone: true, lastEditDate: DateTime.now)
        format.html { redirect_to tasks_path, notice: "Task was successfully set as done." }
        format.json { render :index, status: :ok, location: @undoneTask }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def setAsNotDone
    @undoneTask = current_user.tasks.find(params[:id])
    respond_to do |format|
      if @undoneTask.update(isDone: false, lastEditDate: DateTime.now)
        format.html { redirect_to tasks_path, notice: "Task was successfully set as done." }
        format.json { render :index, status: :ok, location: @undoneTask }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :isDone, :tag_list).merge(lastEditDate: DateTime.now)
    end

    def doneTask_params
      params.require(:task).permit(:title, :description, :isDone, :tag_list).merge(lastEditDate: DateTime.now)
    end

end
