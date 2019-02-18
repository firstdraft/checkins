# frozen_string_literal: true

class CheckInsController < ApplicationController
  before_action :set_check_in, only: %i[show edit update destroy approve_check_in disapprove_check_in]

  def index
    @check_ins = CheckIn.where(enrollment: current_enrollment)
  end

  def show; end

  def new
    @check_in = CheckIn.new
  end

  def edit; end

  def create
    @check_in = CheckIn.new(check_in_params)
    respond_to do |format|
      if @check_in.save
        format.html { redirect_to resource_url(@check_in.resource) }
        # format.html { redirect_to resource_url(@check_in.resource), notice: result }
        format.json { render :show, status: :created, location: @check_in }
      else
        format.html { render :new }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @check_in.update(check_in_params)
        format.html { redirect_to @check_in.resource, notice: "Checkin was successfully updated." }
        format.json { render :show, status: :ok, location: @check_in }
      else
        format.html { render :edit }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @check_in.destroy
    respond_to do |format|
      format.html { redirect_to resource_url(@check_in.resource), notice: "Check in was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def approve_check_in
    @check_in.update(approved: true) unless @check_in.approved

    redirect_to @check_in.resource
  end

  def disapprove_check_in
    @check_in.update(approved: false) if @check_in.approved

    redirect_to @check_in.resource
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:id])
  end

  def check_in_params
    params.require(:check_in).permit(:submission_id, :meeting_id, :latitude, :longitude, :approved)
  end
end
