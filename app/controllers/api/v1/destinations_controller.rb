class Api::V1::DestinationsController < ApplicationController
  before_action :current_user
  skip_before_action :authenticate!

  def index
    @destinations = @user.destinations.each do |val|
      val.set_all_visit_num
      val.set_all_destination_num
    end

    ok, @fields = Destination.new.output_column(params[:fields]&.split(','))
    if ok
      render :index, status: :ok
    else
      @error_params = ErrorDefine.new.get_error_params(4221)
      render 'error/error', status: :unprocessable_entity
    end
  end

  ####################################################################################

  def show
    @destination = current_user.destinations.find_by(id: params[:id])
    _, @fields = @destination.output_column

    # 取得に失敗したら404を返却
    unless @destination
      @error_params = ErrorDefine.new.get_error_params(404)
      render 'error/error', status: :not_found
      return
    end

    full_data = Search::FullData.new

    # Google APIから全ての行き先情報を取得
    status, @result = full_data.get_full_data(position_params, @destination.place_id)

    # 値を返却
    render :show, status: status
  end

  ####################################################################################

  def update
    @destination = Destination.find(params[:id])
    @destination.is_visit = destination_params[:is_visit]
    if destination_params[:is_visit]
      @destination.visited_at = DateTime.now
    end

    if @destination.save
      @destination.set_all_visit_num.set_all_destination_num
      ok, @fields = Destination.new.output_column
      render :update, status: :ok
    else
      @error_params = ErrorDefine.new.get_error_params(4222)
      render 'error/error', status: :unprocessable_entity
    end
  end

  ####################################################################################

  def create
    @destination = @user.destinations.new(destination_params)

    if @destination.save
      render :create, status: :created
    else
      @error_params = ErrorDefine.new.get_error_params(4222)
      render :error, status: :unprocessable_entity
    end
  end

  ####################################################################################

  def destroy
    if Destination.find(params[:id]).destroy
      render :destroy, status: :no_content
    end
  end

  private ############################################################################

  def current_user
    @user = User.find(params[:user_id])
  end

  ####################################################################################

  def destination_params
    params.require(:destination).permit(
      :name,
      :place_id,
      :picture,
      :address,
      :review_rank,
      :review_num,
      :lat,
      :lng,
      :is_visit
    )
  end

  ####################################################################################

  def position_params
    params.permit(
      :lat,
      :lng
    )
  end
end
