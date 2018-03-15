class LaunchesController < ApplicationController
  def index
    @launches = Launch.all

    render("launch_templates/index.html.erb")
  end

  def show
    @launch = Launch.find(params.fetch("id_to_display"))

    render("launch_templates/show.html.erb")
  end

  def new_form
    render("launch_templates/new_form.html.erb")
  end

  def create_row
    @launch = Launch.new

    @launch.payload = params.fetch("payload")
    @launch.enrollment_id = params.fetch("enrollment_id")
    @launch.credential_id = params.fetch("credential_id")

    if @launch.valid?
      @launch.save

      redirect_to("/launches", :notice => "Launch created successfully.")
    else
      render("launch_templates/new_form.html.erb")
    end
  end

  def edit_form
    @launch = Launch.find(params.fetch("prefill_with_id"))

    render("launch_templates/edit_form.html.erb")
  end

  def update_row
    @launch = Launch.find(params.fetch("id_to_modify"))

    @launch.payload = params.fetch("payload")
    @launch.enrollment_id = params.fetch("enrollment_id")
    @launch.credential_id = params.fetch("credential_id")

    if @launch.valid?
      @launch.save

      redirect_to("/launches/#{@launch.id}", :notice => "Launch updated successfully.")
    else
      render("launch_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @launch = Launch.find(params.fetch("id_to_remove"))

    @launch.destroy

    redirect_to("/launches", :notice => "Launch deleted successfully.")
  end
end
