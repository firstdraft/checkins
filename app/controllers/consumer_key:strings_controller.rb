class ConsumerKey:stringsController < ApplicationController
  def index
    @consumer_key:strings = ConsumerKey:string.all

    render("consumer_key:string_templates/index.html.erb")
  end

  def show
    @consumer_key:string = ConsumerKey:string.find(params.fetch("id_to_display"))

    render("consumer_key:string_templates/show.html.erb")
  end

  def new_form
    render("consumer_key:string_templates/new_form.html.erb")
  end

  def create_row
    @consumer_key:string = ConsumerKey:string.new

    @consumer_key:string.consumer_secret = params.fetch("consumer_secret")
    @consumer_key:string.administrator_id = params.fetch("administrator_id")
    @consumer_key:string.enabled = params.fetch("enabled")

    if @consumer_key:string.valid?
      @consumer_key:string.save

      redirect_to("/consumer_key:strings", :notice => "Consumer key:string created successfully.")
    else
      render("consumer_key:string_templates/new_form.html.erb")
    end
  end

  def edit_form
    @consumer_key:string = ConsumerKey:string.find(params.fetch("prefill_with_id"))

    render("consumer_key:string_templates/edit_form.html.erb")
  end

  def update_row
    @consumer_key:string = ConsumerKey:string.find(params.fetch("id_to_modify"))

    @consumer_key:string.consumer_secret = params.fetch("consumer_secret")
    @consumer_key:string.administrator_id = params.fetch("administrator_id")
    @consumer_key:string.enabled = params.fetch("enabled")

    if @consumer_key:string.valid?
      @consumer_key:string.save

      redirect_to("/consumer_key:strings/#{@consumer_key:string.id}", :notice => "Consumer key:string updated successfully.")
    else
      render("consumer_key:string_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @consumer_key:string = ConsumerKey:string.find(params.fetch("id_to_remove"))

    @consumer_key:string.destroy

    redirect_to("/consumer_key:strings", :notice => "Consumer key:string deleted successfully.")
  end
end
