class RecipesController < ApplicationController

  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order("created_at DESC")
  end

  def show
    # @recipe
    @op = @recipe.user_id
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Successfully created new recipe!"
    else 
      render 'new'
    end
  end

  def edit
    # @recipe
  end

  def update
    # @recipe
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    # @recipe
    @recipe.destroy
    redirect_to root_path, notice: "Successfully deleted recipe"
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image, 
          ingredients_attributes: [:id, :name, :_destroy],
          directions_attributes:  [:id, :step, :_destroy]
                      )
  end

  def correct_user
    @user = User.find(@recipe.user_id)
    redirect_to root_url unless current_user == @user
  end 


end