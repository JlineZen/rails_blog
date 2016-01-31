class Api::CategoriesController < ApplicationController
	def index
		categories = Category.all
		render json: categories, Serializer: CategorySerializer
	end

	def create
		if Category.exists?(name: params[:category][:name])
			render json: { error: 'category already exist' }, status: 422
		else
			Category.create(category_params).tap do |category|
				category.save
				render json: { message: 'success' }, status: 201
			end
		end
	end

	def destroy
		if Category.exists?(id: params[:id])
			Category.find_by(id: params[:id]).tap do |category|
				category.destroy
				render json: { message: 'success' }, status: 204
			end
		else		
			render json: { error: 'Category not found' }, status: 422
		end
	end

	def update
		if Category.exists?(id: params[:id])
			Category.find_by(id: params[:id]).tap do |category|
				category.update(category_params)
				render json: { message: 'success' }, status: 201
			end
		else		
			render json: { error: 'Category not found' }, status: 422
		end
	end 

	private
	def category_params
		params.require(:category).permit(:id,:name)  
	end
end
