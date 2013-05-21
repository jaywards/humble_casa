module ServicesHelper

	def check_availability(all_services, category)
		all_services.each do |s|
			if s.category == category
				return true
			end
		end
		return false
	end

	def area_services(property_zip)
		Service.find(ServiceZip.where(:zip => property_zip).map(&:service_id).uniq)
	end

	def area_category_services(property_zip, category)
		Service.where(:category => category, :id => area_services(@property.zip))
	end

end
