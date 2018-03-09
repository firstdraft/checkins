class CredentialsController < ApplicationController
  def index
    @credentials = Credential.all

    render("credential_templates/index.html.erb")
  end

  def show
    @credential = Credential.find(params.fetch("id_to_display"))

    render("credential_templates/show.html.erb")
  end

  def new_form
    render("credential_templates/new_form.html.erb")
  end

  def create_row
    @credential = Credential.new

    @credential.consumer_key = params.fetch("consumer_key")
    @credential.consumer_secret = params.fetch("consumer_secret")
    @credential.administrator_id = params.fetch("administrator_id")
    @credential.enabled = params.fetch("enabled")

    if @credential.valid?
      @credential.save

      redirect_to("/credentials", :notice => "Credential created successfully.")
    else
      render("credential_templates/new_form.html.erb")
    end
  end

  def edit_form
    @credential = Credential.find(params.fetch("prefill_with_id"))

    render("credential_templates/edit_form.html.erb")
  end

  def update_row
    @credential = Credential.find(params.fetch("id_to_modify"))

    @credential.consumer_key = params.fetch("consumer_key")
    @credential.consumer_secret = params.fetch("consumer_secret")
    @credential.administrator_id = params.fetch("administrator_id")
    @credential.enabled = params.fetch("enabled")

    if @credential.valid?
      @credential.save

      redirect_to("/credentials/#{@credential.id}", :notice => "Credential updated successfully.")
    else
      render("credential_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @credential = Credential.find(params.fetch("id_to_remove"))

    @credential.destroy

    redirect_to("/credentials", :notice => "Credential deleted successfully.")
  end
end
