class MaterialsController < ApplicationController
  before_action :set_material, only: %i[show update destroy]

  def index
    materials = policy_scope(Material)
                  .includes(:author)
                  .order(created_at: :desc)
                  .page(params[:page])
                  .per((params[:per] || 10).to_i)

    render json: materials.as_json(
      only: %i[id title description author_id created_at updated_at],
      include: { author: { only: %i[id name] } }
    )
  end

  def show
    authorize @material
    render json: @material.as_json(
      only: %i[id title description author_id created_at updated_at],
      include: { author: { only: %i[id name] } }
    )
  end

  def create
    @material = Material.new(material_params)
    authorize @material

    if @material.save
      render json: @material.as_json(
        only: %i[id title description author_id created_at updated_at],
        include: { author: { only: %i[id name] } }
      ), status: :created
    else
      render json: { errors: @material.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @material

    if @material.update(material_params)
      render json: @material.as_json(
        only: %i[id title description author_id created_at updated_at],
        include: { author: { only: %i[id name] } }
      )
    else
      render json: { errors: @material.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @material
    @material.destroy
    head :no_content
  end

  private

  def set_material
    @material = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit(:title, :description, :author_id)
  end
end

