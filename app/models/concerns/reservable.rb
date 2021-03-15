module Reservable
   extend ActiveSupport::Concern

  def openings(start_date, end_date)
    # binding.pry
    listings.merge(Listing.available(start_date, end_date))
  end

  def ratio_reservations_to_listings
    if listings.count > 0
      reservations.count.to_f / listings.count.to_f
    else
      0
    end
  end

  class_methods do
    # use of 'class_methods' is good, but I think is something that the curriculum 
    # does not currently cover, so would need to be added.
    def highest_ratio_reservations_to_listings
      # objs = self.all
      # ratios = Hash.new.tap {|hash|
      #   objs.each {|obj|
      #     # if obj.listings.count > 0
      #     #   hash["#{obj.id}"] = obj.reservations.count.to_f / obj.listings.count.to_f
      #     # end
      #     if obj.reservations.count.to_f != 0
      #       hash["#{obj.id}"] = obj.reservations.count.to_f / obj.listings.count.to_f
      #     else
      #       hash["#{obj.id}"] = 0
      #     end
      #   }
      # }
      # self.find_by_id(ratios.key(ratios.values.max))

      all.max do |a, b|
        a.ratio_reservations_to_listings <=> b.ratio_reservations_to_listings
      end
    end

    def most_reservations
      all.max do |a, b|
        a.reservations.count <=> b.reservations.count
      end
    end
  end
end
