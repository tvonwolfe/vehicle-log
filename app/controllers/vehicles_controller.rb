class VehiclesController < ApplicationController
  def index
    render Views::Vehicles::Index.new(current_user.vehicles)
  end
end
