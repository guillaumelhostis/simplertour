# app/controllers/pdf_generator_controller.rb
class PdfGeneratorController < ApplicationController
  def generate_pdf
    # Fetch the data you want to display in the PDF
    require 'prawn/measurement_extensions'


    @concert = Concert.find(params[:id])
    @tour = Tour.find(params[:tour])
    @venue = Venue.find(params[:venue])
    @crew = Crew.find(@tour.crew_id)
    @crew_users = CrewUser.where(crew_id: @crew)
    @contacts = Contact.where(concert_id: @concert.id)
    @timetable = TimetableEntry.where(concert_id: @concert.id)
    @hotels = ConcertHotel.where(concert_id: @concert.id)



    authorize @concert




    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new



        # Loop through your instances and add data to the PDF

        pdf.stroke_axis(step_length: 20, color: '0000FF')


        #HEADER
        pdf.bounding_box([0, 720], width: 540, height: 90) do
          pdf.transparent(0.5) { pdf.stroke_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }

          # Define the width for the image section and text section
          image_width = 100
          text_width = pdf.bounds.width - image_width



            tour_picture = StringIO.open(@tour.picture.download)
            pdf.image tour_picture, fit: [image_width, pdf.bounds.height]




          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-Bold.ttf") do
            pdf.text_box @tour.title.upcase, width: text_width, height: pdf.bounds.height,
              align: :center, valign: :center, size: 24
          end

        end


        #CITY
        pdf.bounding_box([0, 620], width: 540, height: 40) do
          pdf.fill_color 'CCCCCC' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-Italic.ttf") do
            pdf.text_box @concert.location.upcase, at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            align: :center, valign: :center, size: 18
          end
        end

        pdf.move_down 10

        #VENUE & DATE
        pdf.font("#{Rails.root}/app/assets/fonts/Roboto-Bold.ttf") do
          pdf.text "#{@venue.name.upcase} - #{@concert.date.strftime('%d/%m/%Y')}", align: :center, size: 14
        end

        pdf.move_down 10

        #VENUE INFOS

        font_path = "#{Rails.root}/app/assets/fonts"
        pdf.font_families.update(
          'Roboto' => {
            normal: { file: "#{font_path}/Roboto-Regular.ttf" },
            italic: { file: "#{font_path}/Roboto-Italic.ttf" },
            bold: { file: "#{font_path}/Roboto-Bold.ttf" },
            bold_italic: { file: "#{font_path}/Roboto-BoldItalic.ttf" }
          }
        )

        pdf.bounding_box([0, 550], width: 540, height: 14) do


          pdf.font 'Roboto'
          pdf.text_box "<b>Capacity:</b> #{@venue.capacity}   |    <b>Tickets sold:</b> SOLD OUT", at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
          valign: :center, size: 9, inline_format: true

        end

        pdf.bounding_box([0, 540], width: 540, height: 14) do
          pdf.font 'Roboto'
          pdf.text_box "<b>Address:</b> #{@venue.address} #{@venue.postcode} #{@venue.city} #{@venue.country}", at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
          valign: :center, size: 9, inline_format: true
        end

        #CONTACTS LOCAL


        line_spacing = 10 # Set the vertical spacing between lines
        @contacts.each_with_index do |contact, index|
          pdf.bounding_box([0, 520 - (line_spacing * index)], width: 540, height: 14) do
            pdf.font 'Roboto'

            contact_text = "<b>#{contact.role}:</b>#{' '}<i>#{contact.full_name} #{' ' * 3} #{contact.country_code}#{contact.phone_number} #{' ' * 3} <color rgb='0000FF'>#{contact.email}</i></color>"

            pdf.text_box contact_text, at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 9, inline_format: true
          end
        end

        next_div = 520 - (line_spacing * (@contacts.length + 1))

        #CITY
        pdf.bounding_box([0, next_div], width: 540, height: 20) do
          pdf.fill_color 'CCCCCC' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-Italic.ttf") do
            pdf.text_box "CREW", at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            valign: :center, size: 12
          end
        end

        line_spacing = 10 # Set the vertical spacing between lines

        @crew_users.each_with_index do |crew_user, index|
          pdf.bounding_box([0, (next_div - 20) - (line_spacing * index)], width: 540, height: 14) do
            pdf.font 'Roboto'

            crew_text = "<b>#{crew_user.role}:</b>#{' ' * 3}<i>#{User.find(crew_user.user_id).first_name}#{' '}#{User.find(crew_user.user_id).last_name} #{' ' * 3}  <color rgb='0000FF'>#{User.find(crew_user.user_id).email}</i></color>"

            pdf.text_box crew_text, at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 9, inline_format: true
            @count = (next_div - 20) - (line_spacing * index)
          end
        end

        next_div = @count - 20

        pdf.bounding_box([0, next_div], width: 540, height: 20) do
          pdf.fill_color 'CCCCCC' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-Italic.ttf") do
            pdf.text_box "VHR", at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            valign: :center, size: 12
          end
        end

        count = 0

        @hotels.each_with_index do |hotel, index|

          @line_spacing = (next_div - 20) - (line_spacing * index) - (count)


          pdf.bounding_box([0, @line_spacing], width: 540, height: 14) do
            pdf.font 'Roboto'
            hotel_users = ConcertHotelUser.where(concert_hotel_id: hotel.hotel_id)
            user_names = hotel_users.map { |user| User.find(user.user_id).full_name }
            user_names_string = user_names.join(', ')



            hotel_name = "<b>#{Hotel.find(hotel.hotel_id).name}</b> (<font size='8'>#{user_names_string}</font>)"
            pdf.text_box hotel_name, at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 9, inline_format: true
          end
          address =  @line_spacing - 10
          pdf.bounding_box([0, address], width: 540, height: 14) do
            pdf.font 'Roboto'
            hotel_address = "<i>#{Hotel.find(hotel.hotel_id).address} <b>#{Hotel.find(hotel.hotel_id).city}</b></i>"
            pdf.text_box hotel_address, at: [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 9, inline_format: true
          end
          count += 20

        end














        # Save the PDF to a file or send it as a download
        pdf_file = Tempfile.new(["instances", ".pdf"])
        pdf_file.binmode
        pdf_file.write(pdf.render)
        pdf_file.close

        send_file pdf_file.path, filename: "#{@tour.artist}_#{@concert.location}_#{@concert.date}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
end
