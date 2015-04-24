class ScheduleController < ApplicationController
  # GET /
  def index
    if current_user
      @week = Week.for_date(Time.now)
      @reservations = Reservation.where(:week_id => @week.id)
    else
      redirect_to '/signin'
    end
  end

  # GET /register.json
  def register
    if current_user
      # TODO: validate all params (day_index and time_start)
      # TODO: check if the reservation is already in the database (server-side validation)
      respond_to do |format|
        format.json { render :json => _register_reservation }
        # format.html: TODO
      end
    else
      redirect_to '/signin'
    end
  end

  # GET /unregister.json
  def unregister
    if current_user
      respond_to do |format|
        format.json { render :json => _unregister_reservation }
        # format.html: TODO
      end
    else
      redirect_to '/signin'
    end
  end

  # GET /toggle_register
  def toggle_register
    if current_user
      @res = Reservation.where(:user => current_user.id, 
        :week => Week.for_date(Time.now),
        :time_start => params[:time_start],
        :day_index => params[:day_index]).first

      respond_to do |format|
        format.json do
          if @res
            status = _unregister_reservation
            if status
              render :json => {'unregister' => 'ok', 'username' => current_user.username}
            else
              render :json => {'unregister' => 'fail', 'username' => current_user.username}
            end
          else
            status = _register_reservation
            if status
              render :json => {'register' => 'ok', 'username' => current_user.username}
            else
              render :json => {'register' => 'fail', 'username' => current_user.username}
            end
          end
        end
      end
    else
      redirect_to '/signin'
    end
  end

  private

  def _unregister_reservation
    @res = Reservation.where(:user => current_user.id, 
      :week => Week.for_date(Time.now),
      :time_start => params[:time_start],
      :day_index => params[:day_index]).first

    if @res
      @res.destroy
    else
      nil
    end
  end

  def _register_reservation
    @res = Reservation.new(
      :user => current_user, :week => Week.for_date(Time.now),
      :time_start => params[:time_start], :time_end => params[:time_start].to_i + 1,
      :day_index => params[:day_index])

    if @res.save
      @res
    else
      nil
    end
  end
end
