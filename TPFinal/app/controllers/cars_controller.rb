class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /cars
  # GET /cars.json
  def index

    @cars = Car.all
    @cars = @cars.where(:fuel_id => params[:fuel_id]) unless params[:fuel_id].blank?
    @cars = @cars.where(:type_id => params[:type_id]) unless params[:type_id].blank?
    @cars = @cars.where(:brand => params[:brand]) unless params[:brand].blank?
    @cars = @cars.where(:model => params[:model]) unless params[:model].blank?

    if params[:from] && params[:to]
      @cars = Car.filter(params[:from] , params[:to])
    end 
  end

  def find_schedules
  if params[:from] && params[:to]
   start_date = params[:from]
   end_date = params[:to]
   @cars = Car.find(:all, :conditions => {:coursedate => start_date..end_date})
  redirect_to :action => 'find_results'  
  end
end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:patent, :brand, :model, :price_day, :fuel_id, :type_id)
    end
end
