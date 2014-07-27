class ListsController < ApplicationController

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
		@list = List.find(params[:id])
	end

	def edit
		@list = List.find(params[:id])
	end

	def update
		@list = List.find(params[:id])
		if @list.update_attributes(list_params)
			flash[:notice] = "List updated."
			respond_with(@list, :location => list_url(@list))
		else
			flash[:error] = "Could not update list."
			redirect_to edit_list_path
		end
	end

	def destroy
		@list = List.find(params[:id])
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
		params.require(:list).permit(:create, :show, :update)
	end

end
