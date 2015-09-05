module UsersHelper

#Defining a gravatar_for helper method. Returns the Gravatar for the given user.
  def gravatar_for(user, options = {})     #optional size parameter, Exercise7
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)      #Exercise7
    size =  options[:size]                           #optional size parameter, atrribute defined    #Exercise7
    
    # without size parameter:     gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}#?s=#{size}"       #optional size parameter accounted for
    
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
