class UsersController < ApplicationController
  before_action :authorize_lti_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all

    render("user_templates/index.html.erb")
  end

  def show
    render("user_templates/show.html.erb")
  end

  def new_form
    render("user_templates/new_form.html.erb")
  end

  def create_row
    @user = User.new

    @user.first_name = params.fetch("first_name")
    @user.last_name = params.fetch("last_name")
    @user.preferred_name = params.fetch("preferred_name")
    @user.lti_user_id = params.fetch("lti_user_id")

    if @user.valid?
      @user.save

      redirect_to("/users", :notice => "User created successfully.")
    else
      render("user_templates/new_form.html.erb")
    end
  end

  def edit
    render "/user_templates/edit.html.erb"
  end

  def update
    @user.update(user_params)
    # @user.first_name = params.fetch("first_name")
    # @user.last_name = params.fetch("last_name")
    # @user.preferred_name = params.fetch("preferred_name")
    # @user.lti_user_id = params.fetch("lti_user_id")

    if @user.valid?
      @user.save

      redirect_to(user_url, :notice => "User updated successfully.")
    else
      render("user_templates/edit.html.erb")
    end
  end

  def destroy
    @user.destroy

    redirect_to("/users", :notice => "User deleted successfully.")
  end

  def sign_out
    session[:enrollment_id] = nil
    session[:launch_id] = nil
    session[:resource_id] = nil
    redirect_to landing_url
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :preferred_name)
    end
end
