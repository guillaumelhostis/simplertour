class ConcertTemplatesController < ApplicationController
  def new
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
    authorize  @concert_template
    @concert_template.save

    redirect_to concert_template_path(@concert_template), notice: 'Template created'
  end

  def create
  end

  def show
    @phoneprefix = ISO3166::Country.all.map { |country| "#{country.country_code}" }
    @phoneprefixsorted = @phoneprefix.uniq.sort_by(&:to_i).map {|c| "+#{c}"}
    @concert_template = ConcertTemplate.find(params[:id])
    authorize  @concert_template
    data = JSON.parse(@concert_template.data)
    @contacts_data = data['contacts']
    @timetable_entries_data = data['timetable_entries'].sort_by! { |entry| entry['hourminute'] }
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
end
