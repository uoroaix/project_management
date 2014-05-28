class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tasks, only: [:edit, :destroy, :update, :status]
  
  def create
    @project = current_user.projects.find_by_id(params[:project_id])
    # @project = Project.find params[:project_id]
    if @project
      @task = @project.tasks.new(task_attributes)
      @task.user = current_user
      if @task.save
        redirect_to @project, notice: "Task Created Succefully!"
      else
        @tasks = @project.tasks.ordered_by_creation
        @discussions = @project.discussions
        render '/projects/show', alert: "Task was not created!"
      end
    else
      redirect_to root_path, alert: "Access Denied" unless @project
    end

  end

  def status   
    if @task.status == "Not Done"
      @task.status = "Done"
    else
      @task.status = "Not Done"
    end
    @task.save
    redirect_to @project
  end

	def index
	end

	def new
	end

	def edit
    
	end

	def show
    @project = Project.find params[:project_id]
    @task = @project.tasks.find(params[:id])
	end

	def update  
    if @task.update_attributes(task_attributes)
      redirect_to @project, notice: "Question updated successfully!"
    else
      render :edit, alert: "Couldn't Update!"
    end
	end

	def destroy
    
    if @task.destroy
      redirect_to @project, notice: "Task Deleted Succefully!"
    else
      redirect_to @project, alert: "We are sorry, there was an error in deleting your Task!"
    end
	end

	private

  def task_attributes
    params.require(:task).permit([:title, :body])
  end	


  def find_tasks
    # @project = Project.find params[:project_id]
    # @task = @project.tasks.find(params[:id])

    @project = current_user.projects.find_by_id(params[:project_id])
    if @project
      @task = @project.tasks.find(params[:id])
    else
      redirect_to root_path, alert: "Access Denied"
    end
  end

end
