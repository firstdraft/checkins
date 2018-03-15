class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all

    render("enrollments/index.html.erb")
  end

  def show
    @enrollment = Enrollment.find(params.fetch("id_to_display"))

    render("enrollments/show.html.erb")
  end

  def new_form
    render("enrollments/new_form.html.erb")
  end

  def create_row
    @enrollment = Enrollment.new

    @enrollment.roles = params.fetch("roles")
    @enrollment.user_id = params.fetch("user_id")
    @enrollment.context_id = params.fetch("context_id")

    if @enrollment.valid?
      @enrollment.save

      redirect_to("/enrollments", :notice => "Enrollment created successfully.")
    else
      render("enrollments/new_form.html.erb")
    end
  end

  def edit_form
    @enrollment = Enrollment.find(params.fetch("prefill_with_id"))

    render("enrollments/edit_form.html.erb")
  end

  def update_row
    @enrollment = Enrollment.find(params.fetch("id_to_modify"))

    @enrollment.roles = params.fetch("roles")
    @enrollment.user_id = params.fetch("user_id")
    @enrollment.context_id = params.fetch("context_id")

    if @enrollment.valid?
      @enrollment.save

      redirect_to("/enrollments/#{@enrollment.id}", :notice => "Enrollment updated successfully.")
    else
      render("enrollments/edit_form.html.erb")
    end
  end

  def destroy_row
    @enrollment = Enrollment.find(params.fetch("id_to_remove"))

    @enrollment.destroy

    redirect_to("/enrollments", :notice => "Enrollment deleted successfully.")
  end
end
