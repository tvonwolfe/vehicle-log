class LogEntriesController < ApplicationController
  before_action :set_vehicle, only: %i[index create new]
  before_action :set_log_entry, only: %i[show edit update destroy]
  authorize_resource

  def index
    render html: "<h1>here</h1>"
  end

  def create
  end

  def show
    render html: "#{log_entry.vehicle.vin}"
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  attr_reader :log_entry, :log_entries, :vehicle

  def set_log_entry = @log_entry = LogEntry.find(params[:id])

  def set_vehicle = @vehicle = current_user.vehicles.find_by!(vin: params[:vehicle_vin])
end
