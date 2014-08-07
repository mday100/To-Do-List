class ListsController < ApplicationController

	before_filter :find_list, only: [:show, :edit, :update, :destroy]
	respond_to :html, :xml, :js

	def index
		respond_with(@lists = List.all)
	end

	def new
		@list = List.new
	end

	def create
		@list = List.new(list_params)
		if @list.save
			flash[:notice] = "List created."
			respond_with(@list, :location => list_url(@list))
		else
			flash[:error] = "Could not create list."
			redirect_to new_list_url
		end
	end

	def show
		@tasks = @list.tasks
		@task = Task.new
	end

	def edit
	end

	def update
		if @list.update_attributes(list_params)
			flash[:notice] = "List updated."
			respond_with(@list, :location => list_url(@list))
		else
			flash[:error] = "Could not update list."
			redirect_to edit_list_path
		end
	end

	def destroy
		if @list.destroy
			flash[:notice] = "List deleted."
			redirect_to lists_url
		else
			flash[:error] = "Could not delete list. Have you done everything?"
			redirect_to lists_url
		end
	end

	private

	def list_params
		params.require(:list).permit(:name, :description)
	end

	def find_list
		@list = List.find(params[:id])
	end

end
