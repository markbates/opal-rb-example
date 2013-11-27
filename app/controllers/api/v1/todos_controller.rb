class Api::V1::TodosController < Api::V1::ApiController
  inherit_resources

  def create
    create! do |format|
      format.json do
        handle_resource
      end
    end
  end

  def update
    update! do |format|
      format.json do
        handle_resource
      end
    end
  end

  private
  def handle_resource
    if resource.errors.any?
      render json: resource.errors, status: :unprocessable_entity
    else
      render json: resource
    end
  end

  def collection
    @collection || Todo.order("created_at asc")
  end

  def permitted_params
    params.permit(todo: [:subject, :body, :completed])
  end
end
