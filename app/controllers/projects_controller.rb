class ProjectsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	before_action :find_project, only: [:edit, :destroy, :update]

	def index
		@projects = Project.all
	end

	def create
		@project = Project.new(project_attributes)
		@project.user = current_user

		if @project.save
			# flash[:notice] = "Your question was created successfully!"
			redirect_to projects_path, notice: "Your project was created successfully!"
		else
			render :new, alert: "We are sorry, your project was not created. Please try again."
		end

	end

	def new
		@project = Project.new
	end

	def edit
	end

	def show
		@project = Project.find(params[:id])
		@task = Task.new
		@tasks = @project.tasks.ordered_by_creation
		@discussions = @project.discussions
	end

	def update
		if @project.update_attributes(project_attributes)
			redirect_to @project, notice: "Your project was updated!"
		else
			render :edit, alert: "Error Occured."
		end
	end

	def destroy
		if @project.destroy
			redirect_to projects_path, notice: "Your project was deleted!"
		else
			redirect_to projects_path, 
			alert: "We are sorry, an error has occured while deleting your project! Please try again later."
		end
	end


	private

	def project_attributes
		params.require(:project).permit([:title])
	end



	def find_project
		# @project = Project.find(params[:id])

		@project = current_user.projects.find_by_id(params[:id])
		redirect_to root_path, alert: "Access Denied" unless @project
	end

end
