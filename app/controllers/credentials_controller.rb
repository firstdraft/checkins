# frozen_string_literal: true

class CredentialsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_credential, only: %i[show edit update destroy]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @credentials = current_administrator.credentials
  end

  def show; end

  def new
    @credential = Credential.new
  end

  def edit; end

  def create
    @credential = Credential.new(administrator: current_administrator)
    respond_to do |format|
      if @credential.save
        format.html { redirect_to credentials_url, notice: "Credential was successfully created." }
        format.json { render :show, status: :created, location: @credential }
      else
        format.html { render :new }
        format.json { render json: @credential.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @credential.update(credential_params)
        format.html { redirect_to @credential, notice: "Credential was successfully updated." }
        format.json { render :show, status: :ok, location: @credential }
      else
        format.html { render :edit }
        format.json { render json: @credential.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @credential.in?(current_administrator.credentials)
      @credential.destroy
    end

    respond_to do |format|
      format.html { redirect_to credentials_url, notice: "Credential was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_credential
    @credential = Credential.find(params[:id])
  end

  def credential_params
    params.require(:credential).permit(:consumer_key, :consumer_secret, :administrator_id)
  end
end
