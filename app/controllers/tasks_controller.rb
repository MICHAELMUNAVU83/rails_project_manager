class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET projects/1/tasks
  def index
   @tasks = Task.where(project_id: @project.id)
  end

  # GET projects/1/tasks/1
  def show
  end

  # GET projects/1/tasks/new
  def new
    @task = Task.new
    @task.project_id = @project.id
  end

  # GET projects/1/tasks/1/edit
  def edit
  end

  # POST projects/1/tasks
  def create
   @task = Task.new(task_params)
    @task.project_id = @project.id


    if @task.save
      redirect_to([@task.project], notice: 'Task was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT projects/1/tasks/1
  def update
    if @task.update_attributes(task_params)
      redirect_to([@task.project], notice: 'Task was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @task.destroy

    redirect_to project_tasks_url(@project)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :status)
    end
end
