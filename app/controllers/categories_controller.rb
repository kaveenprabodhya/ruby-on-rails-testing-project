class CategoriesController < ApplicationController
    before_action :set_category, only: [:edit, :update, :show]
    def index
        @category = Category.all
    end

    def show
    end

    def edit
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = 'Category was successfully created.'
            redirect_to @category
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end

    def set_category 
        @category = Category.find(params[:id])
    end
end
