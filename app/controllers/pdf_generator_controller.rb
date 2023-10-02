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
    @timetable = TimetableEntry.where(concert_id: @concert.id).order(hourminute: :asc)
    @hotels = ConcertHotel.where(concert_id: @concert.id)



    authorize @concert




    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        font_path = "#{Rails.root}/app/assets/fonts"
        pdf.font_families.update(
          'Roboto' => {
            normal: { file: "#{font_path}/Roboto-Regular.ttf" },
            italic: { file: "#{font_path}/Roboto-Italic.ttf" },
            bold: { file: "#{font_path}/Roboto-Bold.ttf" },
            bold_italic: { file: "#{font_path}/Roboto-BoldItalic.ttf" }
          }
        )




        # Loop through your instances and add data to the PDF

        pdf.stroke_axis(step_length: 20, color: '0000FF')


        #HEADER
        pdf.bounding_box([0, 720], width: 540, height: 90) do
          # Define the width for the image section and text section
          image_width = 100
          text_width = pdf.bounds.width

          tour_picture = StringIO.open(@tour.picture.download)
          pdf.image tour_picture, fit: [image_width, pdf.bounds.height]

          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-Bold.ttf") do
            pdf.text_box "#{@tour.artist.upcase}", at: [0, pdf.bounds.top - 10 ], # Adjust the vertical position here
              width: text_width,
              align: :center, size: 16
            pdf.text_box "#{@tour.title.upcase}", at: [0, pdf.bounds.top - 30], # Adjust the vertical position here
              width: text_width,
              align: :center,  size: 14
          end
          pdf.font 'Roboto'
          pdf.text_box "#{@concert.location.upcase} - #{@concert.date.strftime('%d/%m/%Y')}", at: [0, pdf.bounds.top - 50 ], align: :center, size: 10
          pdf.text_box "<b>#{@venue.name.upcase}</b>", at: [0, pdf.bounds.top - 70 ], align: :center, size: 10, inline_format: true
        end

        cursor = 720 - 100

        #FDR
        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.fill_color '666666' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-bold.ttf") do
            pdf.text_box "FDR", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
             valign: :center, size: 8
          end
        end

        cursor  = cursor - 15
        timetable_count = cursor

        @timetable.each_with_index do |timetable, index|
          pdf.bounding_box([0, timetable_count], width: 540, height: 15) do
            if index.odd?
              pdf.fill_color 'e6e6e6' # Gray background for even lines
            else
              pdf.fill_color 'FFFFFF'  # White background for odd lines
            end

            pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height)}

            pdf.fill_color '000000' # Reset fill color for text
            pdf.font("#{Rails.root}/app/assets/fonts/Roboto-Regular.ttf") do
            # Column 1: timetable.hourminute
              pdf.text_box timetable.hourminute&.strftime('%H:%M'), at: [pdf.bounds.left + 5, pdf.bounds.top],
                valign: :center, size: 8

              # Column 2: timetable.hourminuteend
              if !timetable.hourminuteend.nil?
                pdf.text_box timetable.hourminuteend&.strftime('%H:%M'), at: [pdf.bounds.left + 40, pdf.bounds.top],
                valign: :center, size: 8
              end

              pdf.text_box "|", at: [pdf.bounds.left + 100, pdf.bounds.top],
                valign: :center, size: 8

              # Column 3: timetable.information
              pdf.text_box timetable.information, at: [pdf.bounds.left + 140, pdf.bounds.top],
                valign: :center, size: 8
            end
          end
          timetable_count = timetable_count - 15
        end


        cursor = timetable_count - 10

        #VENUE INFOS

        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.fill_color '666666' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-bold.ttf") do
            pdf.text_box "VENUE INFOS", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8
          end
        end

        cursor = cursor - 15

        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.font 'Roboto'
          pdf.text_box "<b>Address:</b>", at: [pdf.bounds.left + 5, pdf.bounds.top],
            valign: :center, size: 8, inline_format: true
          pdf.text_box "#{@venue.address} #{@venue.postcode} #{@venue.city} #{@venue.country}", at: [pdf.bounds.left + 60, pdf.bounds.top],
          valign: :center, size: 8, inline_format: true
        end

        cursor = cursor - 10

        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.font 'Roboto'
          pdf.text_box "<b>Capacity:</b>", at: [pdf.bounds.left + 5, pdf.bounds.top],
            valign: :center, size: 8, inline_format: true
          pdf.text_box " #{@venue.capacity} ", at: [pdf.bounds.left + 60, pdf.bounds.top],
          valign: :center, size: 8, inline_format: true
        end

        cursor = cursor - 20


        # CONTACTS

        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.fill_color '666666' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-bold.ttf") do
            pdf.text_box "CONTACTS", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8
          end
        end

        cursor = cursor - 15

        @contacts.each_with_index do |contact, index|
          pdf.bounding_box([0, cursor], width: 540, height: 15) do
            if index.odd?
              pdf.fill_color 'e6e6e6' # Gray background for even lines
            else
              pdf.fill_color 'FFFFFF'  # White background for odd lines
            end

            pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height)}

            pdf.fill_color '000000' # Reset fill color for text

            pdf.font 'Roboto'
            pdf.text_box "<b>#{contact.role}:</b>", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8, inline_format: true
            pdf.text_box "#{contact.full_name}", at: [pdf.bounds.left + 60, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            valign: :center, size: 8, inline_format: true
            pdf.text_box "#{contact.country_code} #{contact.phone_number}", at: [pdf.bounds.left + 170, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            valign: :center, size: 8, inline_format: true
            pdf.text_box "<color rgb='0000FF'>#{contact.email}</i></color>", at: [pdf.bounds.left + 260, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            valign: :center, size: 8, inline_format: true
          end
          cursor = cursor - 15
        end

        # CREWS
        cursor = cursor - 10

        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.fill_color '666666' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-bold.ttf") do
            pdf.text_box "TODAY CREW", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8
          end
        end

        cursor = cursor - 15

        @crew_users.each_with_index do |crew_user, index|
          pdf.bounding_box([0, cursor], width: 540, height: 15) do
            if index.odd?
              pdf.fill_color 'e6e6e6' # Gray background for even lines
            else
              pdf.fill_color 'FFFFFF'  # White background for odd lines
            end

            pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height)}

            pdf.fill_color '000000' # Reset fill color for text

            pdf.font 'Roboto'

           #{User.find(crew_user.user_id).first_name}#{' '}#{User.find(crew_user.user_id).last_name} #{' ' * 3}  <color rgb='0000FF'>#{User.find(crew_user.user_id).email}</i></color>"

            pdf.text_box "<b>#{crew_user.role}:</b>", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8, inline_format: true
            pdf.text_box "#{User.find(crew_user.user_id).first_name}#{' '}#{User.find(crew_user.user_id).last_name}", at: [pdf.bounds.left + 60, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            valign: :center, size: 8, inline_format: true
            pdf.text_box " <color rgb='0000FF'>#{User.find(crew_user.user_id).email}</i></color>", at: [pdf.bounds.left + 170, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
            valign: :center, size: 8, inline_format: true


          end
          cursor = cursor - 15
        end

        # HOTELS
        cursor = cursor - 10

        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.fill_color '666666' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-bold.ttf") do
            pdf.text_box "HOTELS", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8
          end
        end

        cursor = cursor - 15

        @hotels.each_with_index do |hotel, index|

          pdf.bounding_box([0, cursor], width: 540, height: 15) do
            pdf.font 'Roboto'
            hotel_users = ConcertHotelUser.where(concert_hotel_id: hotel.hotel_id)
            hotel_guests = ConcertHotelGuest.where(concert_hotel_id: hotel.hotel_id)
            user_names = hotel_users.map { |user| User.find(user.user_id).full_name }
            guest_names = hotel_guests.map { |guest| Guest.find(guest.guest_id).full_name }
            user_names_string = user_names.join(', ')
            guest_names_string = guest_names.join(', ')

            hotel_name = "<b>#{Hotel.find(hotel.hotel_id).name}</b> (<font size='7'>#{user_names_string} #{guest_names_string} </font>)"
            pdf.text_box hotel_name, at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8, inline_format: true
          end

          cursor = cursor - 10

          pdf.bounding_box([0, cursor], width: 540, height: 15) do
            pdf.font 'Roboto'
            hotel_address = "#{Hotel.find(hotel.hotel_id).address} <b>#{Hotel.find(hotel.hotel_id).city}</b>"
            pdf.text_box hotel_address, at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 7, inline_format: true
          end

          cursor = cursor - 10

        end

        # NOTES

        cursor = cursor - 10

        pdf.bounding_box([0, cursor], width: 540, height: 15) do
          pdf.fill_color '666666' # Light gray fill color
          pdf.transparent(0.5) { pdf.fill_rectangle([pdf.bounds.left, pdf.bounds.top], pdf.bounds.width, pdf.bounds.height) }
          pdf.fill_color '000000' # Set the text color to black
          pdf.font("#{Rails.root}/app/assets/fonts/Roboto-bold.ttf") do
            pdf.text_box "NOTES", at: [pdf.bounds.left + 5, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height,
              valign: :center, size: 8
          end
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
