class LogEntriesController < ApplicationController
  before_action :set_vehicle, only: %i[index create new]
  before_action :set_log_entry, only: %i[show edit update destroy]
  before_action :verify_service_record_presence, only: %i[show]
  authorize_resource

  def index
    render html: "<h1>here</h1>"
  end

  def create
    new_log_entry = vehicle.log_entries.new(log_entry_params)

    if new_log_entry.save
      redirect_to vehicle, notice: "Entry added."
    else
      render Views::LogEntries::New.new(new_log_entry), status: :unprocessable_entity
    end
  end

  def show
    render Views::LogEntries::Show.new(log_entry)
  end

  def new
    render Views::LogEntries::New.new(vehicle.log_entries.new)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  attr_reader :log_entry, :log_entries, :vehicle

  def verify_service_record_presence
    return if log_entry.service_record.present?

    redirect_to log_entry.vehicle
  end

  def log_entry_params
    params.require(:log_entry).permit(
      :performed_on,
      :mileage,
      service_record_attributes: [
        :title,
        :cost,
        :service_type,
        :description,
        attachments: []
      ]
    )
  end
  def set_log_entry = @log_entry = LogEntry.find(params[:id])

  def set_vehicle = @vehicle = current_user.vehicles.find_by!(vin: params[:vehicle_vin])
end
