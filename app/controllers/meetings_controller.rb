class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show edit attend unattend update destroy]
  before_action :authenticate_user!
  before_action :force_to_pay

  # GET /meetings or /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1 or /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # PUT
  def attend
    user = User.find(params[:user_id])
    respond_to do |format|
      if @meeting.add_participant(user)
        format.html { redirect_to meeting_url(@meeting), notice: 'Happy attending!' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def unattend
    user = User.find(params[:user_id])
    respond_to do |format|
      if @meeting.remove_participant(user)
        format.html { redirect_to meeting_url(@meeting), notice: 'You no longer want to attend this meeting.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting was successfully created. You have gained
                                #{Meeting::ORGANIZE_MEETING_BONUS} activity points." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: 'Meeting was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def meeting_params
    params.require(:meeting).permit(:organizer_id, :title, :location, :time, :date, :description)
  end
end
