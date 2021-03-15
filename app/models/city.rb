class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings

  include Reservable

  def city_openings(start_date, end_date)
    # if start_date && end_date
    #   search_result = Listing.joins(:reservations).
    #     where.not(reservations: {check_in: start_date..end_date}) &
    #     Listing.joins(:reservations).
    #     where.not(reservations: {check_out: start_date..end_date}) &
    #     Listing.joins(:reservations).
    #     where.not('reservations.check_in < ? AND reservations.check_out > ?', start_date, end_date)
    # else
    #   search_result = []
    # end
    # listings.merge(search_result)
    
    # openings(start_date, end_date)
binding.pry
    result = self.listings.to_a
    if start_date && end_date
      self.reservations.each {|reservation|
        if (start_date.to_date < reservation.check_in && end_date.to_date > reservation.check_in) || (end_date.to_date > reservation.check_out && start_date.to_date < reservation.check_out) || (start_date.to_date > reservation.check_in && end_date.to_date < reservation.check_out) || (start_date.to_date < reservation.check_in && end_date.to_date > reservation.check_out)
          result.delete_if {|l| l == reservation.listing}
        end
      }      
    end
    result

  end
end
