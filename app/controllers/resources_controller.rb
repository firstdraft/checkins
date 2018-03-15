class ResourcesController < ApplicationController
  def index
    @resources = Resource.all

    render("resources/index.html.erb")
  end

  def show
    @resource = Resource.find(params.fetch("id_to_display"))

    render("resources/show.html.erb")
  end

  def new_form
    render("resources/new_form.html.erb")
  end

  def create_row
    @resource = Resource.new

    @resource.meeting_schedule_hash = params.fetch("meeting_schedule_hash")
    @resource.lis_outcome_service_url = params.fetch("lis_outcome_service_url")
    @resource.lti_resource_link_id = params.fetch("lti_resource_link_id")
    @resource.context_id = params.fetch("context_id")

    if @resource.valid?
      @resource.save

      redirect_to("/resources", :notice => "Resource created successfully.")
    else
      render("resources/new_form.html.erb")
    end
  end

  def edit_form
    @resource = Resource.find(params.fetch("prefill_with_id"))

    render("resources/edit_form.html.erb")
  end

  def update_row
    @resource = Resource.find(params.fetch("id_to_modify"))

    @resource.meeting_schedule_hash = params.fetch("meeting_schedule_hash")
    @resource.lis_outcome_service_url = params.fetch("lis_outcome_service_url")
    @resource.lti_resource_link_id = params.fetch("lti_resource_link_id")
    @resource.context_id = params.fetch("context_id")

    if @resource.valid?
      @resource.save

      redirect_to("/resources/#{@resource.id}", :notice => "Resource updated successfully.")
    else
      render("resources/edit_form.html.erb")
    end
  end

  def destroy_row
    @resource = Resource.find(params.fetch("id_to_remove"))

    @resource.destroy

    redirect_to("/resources", :notice => "Resource deleted successfully.")
  end
end
