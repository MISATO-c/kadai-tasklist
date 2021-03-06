module UsersHelper
  def gravatar_url(user, options = { size: 80 })

#binding.pry

    gravatar_id = Digest::MD5::hexdigest(current_user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
