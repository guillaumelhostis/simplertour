module ConcertHotelsHelper
  def remove_user_link(tour, concert, concert_hotel, user)
    form_with(url: remove_user_tour_concert_concert_hotel_path(tour, concert, concert_hotel, user_id: user),
              local: true,
              method: :delete,
              data: { remote: true },
              style: 'display: inline; margin-right: 10px;') do |form|
      form.button 'Remove', type: :submit, class: 'remove-user-btn', data: { concert_hotel_id: concert_hotel.id }
    end
  end
end
