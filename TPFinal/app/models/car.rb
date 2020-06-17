class Car < ApplicationRecord
	has_many :services
	has_many :reservations

	before_destroy do
    	services.each { |service| service.destroy }
    	reservations.each { |reservation| reservation.destroy }
  	end

	belongs_to :fuel
	belongs_to :type

	validates :patent, :brand, :model, :price_day, presence: true
	validates :patent, uniqueness: true
	validates :price_day, numericality: true

	def self.filter(from, to)

		si = 0;

		if from > to
    		si = 1;
    	end

		if from.to_s.strip.empty?
			si = 1;
		end

		if to.to_s.strip.empty?
			si = 1;
		end

		from = from.to_date
		to = to.to_date 


		a = Array.new

		if si == 0

			for c in Car.all

				enters = true

				for r in Reservation.all
					if (c.patent == r.car.patent)
						if ((from < r.from) and (to > r.from))
							enters = false
						end

						if((from > r.from) and (from < r.to + 2))
							enters = false
						end

						if((from > r.from) and (to < r.to + 2))
							enters = false
						end

						if((from < r.from) and (to > r.to + 2))
							enters = false
						end
					end
				end

				for s in Service.all
					if (c.patent == s.car.patent)
						if ((from < s.from) and (to > s.from))
							enters = false
						end

						if((from > s.from) and (from < s.to))
							enters = false
						end

						if((from > s.from) and (to < s.to))
							enters = false
						end

						if((from < s.from) and (to > s.to))
							enters = false
						end
					end
				end

				if enters == true
					a.push(c)
				end
			end
		else
			for c in Car.all
				a.push(c)
			end
		end
		
		a

	end
 		
end
