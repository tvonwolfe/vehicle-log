class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[show]

  def index
    render Views::Vehicles::Index.new(current_user.vehicles)
  end

  def show
    render Views::Vehicles::Show.new(vehicle)
  end

  def create
    vehicle = current_user.vehicles.new(vehicle_params)

    if vehicle.save
      redirect_to vehicle_path(vehicle)
    else
      render Views::Vehicles::New.new(vehicle), status: :unprocessable_entity
    end
  end

  def new
    render Views::Vehicles::New.new(Vehicle.new)
  end

  private

  attr_reader :vehicle

  def set_vehicle
    @vehicle = current_user.vehicles.find_by!(vin: params[:vin])
  end

  def vehicle_params
    vehicle_params = params.require(:vehicle).permit(
      :license_plate_number,
      :manufacturer,
      :model,
      :model_year,
      :vin
    )
    vehicle_params[:vehicle]&.each_value { |v| v.try(:strip!) }

    vehicle_params
  end
end
