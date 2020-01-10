# frozen_string_literal: true

class ResourcesController < ApplicationController
  before_action :set_resource, only: %i[show edit update destroy]
  before_action :authorize_lti_user,
                except: %i[teacher_backdoor student_backdoor]
  skip_after_action :verify_authorized,
                    only: %i[teacher_backdoor student_backdoor]

  def index
    @resources = policy_scope(Resource)

    unless current_enrollment.teacher?
      redirect_to current_resource
    end
  end

  def show
    authorize @resource
    request.variant = if current_enrollment.teacher?
                        :teacher
                      else
                        :student
                      end

    @meetings = @resource.meetings.order(:start_time)
    if current_enrollment.teacher?
      @most_recent_meeting = @meetings.gradeable.last
    end
  end

  def new
    @resource = Resource.new
  end

  def edit
    authorize @resource
  end

  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: "Resource was successfully created." }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @resource
    @resource.assign_attributes(resource_params)
    if @resource.inspect != Resource.find(@resource.id).inspect
      if @resource.save
        @resource.create_meetings(params["start_times"], params["end_times"])
        redirect_to @resource,
                    notice: "Resource was successfully updated."
      else
        render :edit
      end
    else
      redirect_to @resource, notice: "Resource was unchanged"
    end
  end

  def destroy
    authorize @resource
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: "Resource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def teacher_backdoor
    @user = User.find_by(
      # from seed data
      lti_user_id: "1403bcc277e378cdb9aba8dc1057b6b8f5ba7514",
    )
    set_back_door_attributes

    redirect_to resource_url(@resource)
  end

  def student_backdoor
    @user = User.find_by(
      # from seed data
      lti_user_id: "d6807dd4a28995e894f5ac891d17f993a293c875",
    )
    set_back_door_attributes

    redirect_to resource_url(@resource)
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(
      :context_id,
      :meeting_schedule_hash,
      :starts_on,
      :ends_on,
      :sunday,
      :monday,
      :tuesday,
      :wednesday,
      :thursday,
      :friday,
      :saturday,
    )
  end

  def set_back_door_attributes
    reset_session
    # from seed data
    @context = Context.find_by(
      # from seed data
      lti_context_id: "b2bc1248f679be9690b070b64d9af2d91daa3380",
    )
    # from seed data
    @resource = Resource.find_by(
      # from seed data
      lti_resource_link_id: "b2dbcfdfb658e18e82fdc909b141aea47270cd3b",
    )
    @enrollment = Enrollment.find_by(context: @context, user: @user)

    @submission = Submission.find_by(
      enrollment: @enrollment,
      resource: @resource,
    )

    session[:enrollment_id] = @enrollment.id
    session[:launch_id] = @enrollment.launches.last.id
    session[:resource_id] = @resource.id
    session[:submission_id] = @submission.try(:id)
  end
end
