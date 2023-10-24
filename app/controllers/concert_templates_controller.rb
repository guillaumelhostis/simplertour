class ConcertTemplatesController < ApplicationController
  def new
    if params[:format] != nil
      concert = Concert.find(params[:format].to_i)
      data = {
        concert: concert.attributes,
        checklists: concert.checklists.map(&:attributes),
        contacts: concert.contacts.map(&:attributes),
        hotels: concert.hotels.map(&:attributes),
        notes: concert.notes.map(&:attributes),
        timetable_entries: concert.timetable_entries.map(&:attributes),
        transports: concert.transports.map(&:attributes),
      }
      @concert_template = ConcertTemplate.new(data: data.to_json, name: params[:template_name])
      @concert_template.tourman_id = current_tourman.id
      authorize  @concert_template
      @concert_template.save
      redirect_to concert_template_path(@concert_template), notice: 'Template created'
    else
      concert = Concert.new
      data = {
        concert: concert.attributes,
        checklists: concert.checklists.map(&:attributes),
        contacts: concert.contacts.map(&:attributes),
        hotels: concert.hotels.map(&:attributes),
        notes: concert.notes.map(&:attributes),
        timetable_entries: concert.timetable_entries.map(&:attributes),
        transports: concert.transports.map(&:attributes),
      }
      @concert_template = ConcertTemplate.new(data: data.to_json, name: "New Template")
      @concert_template.tourman_id = current_tourman.id
      @concert_template.save
      authorize  @concert_template
      redirect_to concert_template_path(@concert_template), notice: 'Template created'
    end
  end

  def create
  end

  def show
    @concert_templates = ConcertTemplate.where(tourman_id: current_tourman.id)
    @tours = Tour.where(tourman_id: current_tourman.id)
    @phoneprefix = ISO3166::Country.all.map { |country| "#{country.country_code}" }
    @phoneprefixsorted = @phoneprefix.uniq.sort_by(&:to_i).map {|c| "+#{c}"}
    @concert_template = ConcertTemplate.find(params[:id])
    authorize  @concert_template
    data = JSON.parse(@concert_template.data)
    @contacts_data = data['contacts']

    @timetable_entries_data = data['timetable_entries']&.sort_by! { |entry| entry['hourminute'] }

    @hotels_data = data['hotels']
    @transports_data = data['transports']
    @notes_data = data['notes']
    @checklists_data = data['checklists']

  end

  def update_notes
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["notes"][params[:index].to_i]["description"] = params[:note_description]
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def new_note
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["notes"] << {"description"=>params[:note_description]}
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def delete_note
    @concert_template = ConcertTemplate.find(params[:id])

    data = JSON.parse(@concert_template.data)
    data["notes"].delete_at(params[:index].to_i)
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def update_timetable
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["timetable_entries"][params[:index].to_i]["information"] = params[:entry]
    data["timetable_entries"][params[:index].to_i]["hourminute"] = params[:start].to_time
    data["timetable_entries"][params[:index].to_i]["hourminuteend"] = params[:end].to_time
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Timetable updated'
  end

  def new_timetable
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["timetable_entries"] << {"information"=>params[:entry], "hourminute"=>params[:start].to_time,"hourminuteend"=>params[:end].to_time }

    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def delete_timetable
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    @timetable_entries_data = data['timetable_entries']&.sort_by! { |entry| entry['hourminute'] }

    @timetable_entries_data.delete_at(params[:index].to_i)
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def update_checkbox
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["checklists"][params[:index].to_i]["description"] = params[:checkbox_description]
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def delete_checkbox
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["checklists"].delete_at(params[:index].to_i)
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def new_checkbox
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["checklists"] << {"description"=>params[:note_description]}
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def new_transport
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["transports"] << {"place_of_depart"=>params[:depart_place], "place_of_arrival"=>params[:arrival_place], "time_of_depart"=>params[:depart_time].to_time, "time_of_arrival"=>params[:arrival_time].to_time, "way_of_transport"=>params[:way_of_transport] }
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Transport Added'
  end

  def update_name
    @concert_template = ConcertTemplate.find(params[:id])
    @concert_template.name = params[:name]
    authorize  @concert_template
    @concert_template.save
    redirect_to concert_template_path(@concert_template), notice: 'Name Updated'
  end

  def update_transport
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["transports"][params[:index].to_i]["place_of_depart"] = params[:place_depart]
    data["transports"][params[:index].to_i]["place_of_arrival"] = params[:place_arrival]
    data["transports"][params[:index].to_i]["time_of_depart"] = params[:time_depart].to_time
    data["transports"][params[:index].to_i]["time_of_arrival"] = params[:time_arrival].to_time
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Transport updated'
  end

  def delete_transport
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["transports"].delete_at(params[:index].to_i)
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Template updated'
  end

  def delete_template
    @concert_template = ConcertTemplate.find(params[:id])
    authorize  @concert_template
    @concert_template.delete
    redirect_to tours_path, notice: 'Template Delete'
  end

  def update_hotel
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["hotels"][params[:index].to_i]["name"] = params[:hotel_name]
    data["hotels"][params[:index].to_i]["address"] = params[:hotel_address]
    data["hotels"][params[:index].to_i]["postcode"] = params[:hotel_postcode]
    data["hotels"][params[:index].to_i]["city"] = params[:hotel_city]
    data["hotels"][params[:index].to_i]["standing"] = params[:standing]
    data["hotels"][params[:index].to_i]["country"] = params[:hotel_country]
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Hotel Updated'
  end

  def delete_hotel
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["hotels"].delete_at(params[:index].to_i)
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Hotel Delete'
  end

  def new_hotel
    @concert_template = ConcertTemplate.find(params[:id])
    data = JSON.parse(@concert_template.data)
    data["hotels"] << {"name"=>params[:hotel_name], "address"=>params[:hotel_address], "city"=>params[:hotel_city], "postcode"=>params[:hotel_postcode], "country"=>params[:hotel_country], "standing"=>params[:standing]}
    authorize  @concert_template
    @concert_template.update(data: data.to_json)
    redirect_to concert_template_path(@concert_template), notice: 'Hotel Added'
  end

  def create_from_template
    @concert_template = ConcertTemplate.find(params[:id])
    authorize  @concert_template
    tour= Tour.find(params[:tour].to_i)
    data = JSON.parse(@concert_template.data)
    new_concert = Concert.new(tour_id: params[:tour].to_i, name: params[:venue], location: params[:city], date: params[:date].to_date)
    new_concert.save
    data["checklists"].each do |checklist|
      checklist = Checklist.new(concert_id: new_concert.id, description: checklist["description"] )
      checklist.save
    end
    data["timetable_entries"].each do |timetable_entry|
      new_timetable_entry = TimetableEntry.new(concert_id: new_concert.id, information: timetable_entry["information"], hourminute: timetable_entry["hourminute"], hourminuteend: timetable_entry["hourminuteend"])
      new_timetable_entry.save
    end

    data["transports"].each do |transport|
      new_transport = Transport.new(concert_id: new_concert.id, time_of_depart: transport["time_of_depart"] , time_of_arrival: transport["time_of_arrival"]  , place_of_depart: transport["place_of_depart"], place_of_arrival: transport["place_of_arrival"], way_of_transport: transport["way_of_transport"])
      new_transport.save
    end
    data["notes"].each do |note|
      new_note = Note.new(concert_id: new_concert.id, description: note["description"])
      new_note.save
    end
    data["hotels"].each do |hotel|
      new_hotel = Hotel.new(name: hotel["name"], address: hotel["address"], city: hotel["city"], postcode: hotel["postcode"], country: hotel["country"], standing: hotel["standing"], tourman_id: hotel["tourman_id"] )
      new_hotel.save
      new_concert_hotel = ConcertHotel.new(concert_id: new_concert.id, hotel_id: new_hotel.id)
      new_concert_hotel.save
    end
    redirect_to tour_concert_path(new_concert, tour), notice: 'Concert was successfully created'
  end
end
