module UsersHelper
  # Returns the Gravatar for the given user.
  def identicon_for(user)
    image_tag("data:image/jpeg;base64,#{RubyIdenticon.create_base64(user.email.downcase)}", class: 'img-thumbnail')
    # gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    # gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    # image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
