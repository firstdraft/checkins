class ContextsController < ApplicationController
  before_action :set_context, only: %i[show edit update destroy]
  before_action :authorize_lti_user

  def index
    @contexts = policy_scope(Context)
  end

  def show
    authorize @context
  end

  def new
    @context = Context.new
    authorize @context
  end

  def edit
    authorize @context
  end

  def create
    @context = Context.new(context_params)

    respond_to do |format|
      if @context.save
        format.html { redirect_to @context, notice: "Context was successfully created." }
        format.json { render :show, status: :created, location: @context }
      else
        format.html { render :new }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @context
    respond_to do |format|
      if @context.update(context_params)
        format.html { redirect_to @context, notice: "Context was successfully updated." }
        format.json { render :show, status: :ok, location: @context }
      else
        format.html { render :edit }
        format.json { render json: @context.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @context
    @context.destroy
    respond_to do |format|
      format.html { redirect_to contexts_url, notice: "Context was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_context
    @context = Context.find(params[:id])
  end

  def context_params
    params.require(:context).permit(:title, :credential_id, :allowed_absences)
  end
end
