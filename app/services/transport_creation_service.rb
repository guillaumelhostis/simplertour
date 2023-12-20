class TransportCreationService

  def initialize(transport_params, concert)
    @transport_params = transport_params
    @concert = concert
    @success = false
  end

  def call
    build_transport
    ajust_schedules
    save_transport
  end

  def success
    @success
  end

  def transport
    @transport
  end

  private

  def build_transport
    @transport= Transport.new(@transport_params.merge(concert_id: @concert.id))
  end

  def ajust_schedules
    concert_date = @concert.date
    arrival_hour = @transport.time_of_arrival.hour
    arrival_minute = @transport.time_of_arrival.min
    depart_hour = @transport.time_of_depart.hour
    depart_minute = @transport.time_of_depart.min
    new_time_of_arrival = Time.new(concert_date.year, concert_date.month, concert_date.day, arrival_hour, arrival_minute)
    new_time_of_depart = Time.new(concert_date.year, concert_date.month, concert_date.day, depart_hour, depart_minute)
    @transport.time_of_arrival = new_time_of_arrival
    @transport.time_of_depart = new_time_of_depart
  end

  def save_transport
    @success = @transport.save
  end
end
