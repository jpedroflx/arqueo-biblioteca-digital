class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show update destroy]

  after_action :verify_authorized,    except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @authors =
      policy_scope(Author)
        .order(created_at: :desc)
        .page(params[:page])
        .per(params.fetch(:per, 10))  # default 10

    render json: @authors
  end

  def show
    authorize @author
    render json: @author
  end

  def create
    @author = Author.new(author_params)
    authorize @author

    if @author.save
      render json: @author, status: :created
    else
      render json: { errors: @author.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    authorize @author
    if @author.update(author_params)
      render json: @author
    else
      render json: { errors: @author.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    authorize @author
    @author.destroy!
    head :no_content
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :bio)
  end
end
