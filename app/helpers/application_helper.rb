module ApplicationHelper

def full_title(page_title)
	base_title = "HumbleCasa"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

	def signed_in?
		!current_user.nil?
	end 

end
