class JobsController < ApplicationController
  def index
  	@jobs = Job.all
  end

  def show
  	@job = Job.find params[:id]
  end

  def new
  	@job = Job.new
  end

  def create
  	@job = Job.create user_params

  	if @job.save
  	  redirect_to action: 'index', controller: 'jobs'
  	else
  	  render 'new'
  	end
  end

  def edit
  	@job = Job.find params[:id]
  end

  def update
  	#@job = Job.find params[:id]
  end

  def destroy
  	#@job = Job.find(params[:id]).destroy
  end

  protected

  def user_params
  	params.require(:job).permit(:name, :description, :salary, :rating, :start_date, :finish_date, :location)
  end
end
