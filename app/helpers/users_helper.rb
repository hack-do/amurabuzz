module UsersHelper

	def profile_pic_tag image,size="70x70",class1="img-thumbnail"
		#puts "\n\n\n\nProfile Pic Size #{size} \n\n\n #{class1}"
		if image.nil?
            image_tag "amura.png", size: size, class: class1
        else
            image_tag current_user.avatar.url, size: size, class: class1
        end
	end

end
