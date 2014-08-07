class TasksController < ApplicationController

	attr_accessor :completed, :incomplete
	before_filter :find_list
	respond_to :html, :xml, :js

	def create
		@task = @list.tasks.new(task_params)
		if @task.save
			flash[:notice] = "Task created."
			redirect_to list_url(@list)
		else
			flash[:error] = "Could not add task at this time."
			redirect_to list_url(@list)
		end
	end

	def complete
		@task = Task.find(params[:id])
		@task.completed = true
		@task.save
		redirect_to list_url(@list)
	end

	private

	def task_params
		params.require(:task).permit(:description, :id)
	end

	def find_list
		@list = List.find(params[:list_id])
	end

end
