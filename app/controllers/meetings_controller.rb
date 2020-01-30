# frozen_string_literal: true

class MeetingsController < ApplicationController
  before_action :set_resource
  before_action :set_meeting, only: %i[show edit update destroy]

  def index
    authorize @resource, :show_meetings?
    @meetings = policy_scope(Meeting).includes(:resource).where(resource: @resource).order(:start_time)
  end

  def show
    authorize @meeting

    @content = Kramdown::Document.new(@meeting.content, input: "GFM")
  end

  def new
    @meeting = @resource.meetings.build
    authorize @meeting
  end

  def edit
    authorize @meeting
  end

  def create
    @meeting = Meeting.new(meeting_params)
    authorize @meeting
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to [@meeting.resource, @meeting], notice: "Meeting was successfully created." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @meeting
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to [@meeting.resource, @meeting], notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @meeting
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to resource_meetings_url, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_resource
    @resource = Resource.find(params[:resource_id])
  end
  
  def set_meeting
    @meeting = @resource.meetings.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:start_time, :end_time, :resource_id, :content)
  end
end
