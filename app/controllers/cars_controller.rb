class CarsController < ApplicationController
  before_action :set_car, only: [:show, :update, :destroy, :update_status]

  # GET /cars
  def index
    @cars = Car.all

    render json: @cars
  end

  # GET /cars/1
  def show
    render json: @car
  end

  # POST /cars
  def create
    @car = Car.new(car_params)

    if @car.save
      render json: @car, status: :created, location: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cars/1
  def update
    if @car.update(car_params)
      render json: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cars/1
  def destroy
    @car.destroy!
  end

  # PUT /cars/:id/update_status
  def update_status
    # binding.pry
    new_status = params[:status].to_i
    unless [0, 1].include?(new_status)
      render json: { error: "Invalid status value. Status must be either 0 or 1." }, status: :unprocessable_entity
      return
    end
    @car.update(status: new_status)
    render json: @car
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:name, :model)
    end
end
