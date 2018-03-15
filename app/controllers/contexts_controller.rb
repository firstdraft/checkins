class ContextsController < ApplicationController
  def index
    @contexts = Context.all

    render("contexts/index.html.erb")
  end

  def show
    @context = Context.find(params.fetch("id_to_display"))

    render("contexts/show.html.erb")
  end

  def new_form
    render("contexts/new_form.html.erb")
  end

  def create_row
    @context = Context.new

    @context.title = params.fetch("title")
    @context.lti_context_id = params.fetch("lti_context_id")
    @context.credential_id = params.fetch("credential_id")

    if @context.valid?
      @context.save

      redirect_to("/contexts", :notice => "Context created successfully.")
    else
      render("contexts/new_form.html.erb")
    end
  end

  def edit_form
    @context = Context.find(params.fetch("prefill_with_id"))

    render("contexts/edit_form.html.erb")
  end

  def update_row
    @context = Context.find(params.fetch("id_to_modify"))

    @context.title = params.fetch("title")
    @context.lti_context_id = params.fetch("lti_context_id")
    @context.credential_id = params.fetch("credential_id")

    if @context.valid?
      @context.save

      redirect_to("/contexts/#{@context.id}", :notice => "Context updated successfully.")
    else
      render("contexts/edit_form.html.erb")
    end
  end

  def destroy_row
    @context = Context.find(params.fetch("id_to_remove"))

    @context.destroy

    redirect_to("/contexts", :notice => "Context deleted successfully.")
  end
end
