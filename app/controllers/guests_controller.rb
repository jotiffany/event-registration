class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :edit, :update, :register, :destroy]
  # GET /guests
  # GET /guests.json
  def index
    @guests = Guest.all
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
  end

  # GET /guests/new
  def new
    @event = Event.find(params[:event_id])
    @guest = Guest.new
  end

  # GET /guests/1/edit
  def edit
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(guest_params)

    respond_to do |format|
      if @guest.save
        @event = @guest.table.event
        format.html { redirect_to @event, notice: 'Guest was successfully created.' }
        format.json { render :show, status: :created, location: @guest }
      else
        format.html { render :new }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guests/1
  # PATCH/PUT /guests/1.json
  def update
    respond_to do |format|
      if @guest.update(guest_params)
        @event = @guest.table.event
        format.html { redirect_to @event, notice: 'Guest was successfully updated.' }
        format.json { render :show, status: :ok, location: @guest }
      else
        format.html { render :edit }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def register
    respond_to do |format|
      if @guest.update(:registered => true)
        @event = @guest.table.event
        success_message = "You have #{pluralize(@guest.assigned_seats, 'seat')} at Table #{@guest.table.number}"
        if params.has_key?(:guest_name)
          format.html { redirect_to registration_event_path(@event), notice: success_message }
          format.json { render :show, status: :ok, location: @guest }
        else
          format.html { redirect_to @event, notice: success_message }
          format.json { render :show, status: :ok, location: @guest }
        end
      else
        format.html { render :edit }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    event = Event.find(params[:event_id])
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @event = @guest.table.event
    @guest.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Guest was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @event = Event.find(params[:event_id])
      if params.has_key?(:guest_name)
        @guest = Guest.joins(:table).where("tables.event_id = ? AND guests.name = ?", @event.id, params[:guest_name]).first
      elsif params.has_key?(:id)
        @guest = Guest.find(params[:id])
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_params
      params.require(:guest).permit(:name, :table_id, :assigned_seats)
    end
end
