class User < ActiveRecord::Base
  serialize :linkedin_data, JSON  

  def self.from_omniauth(auth)
    if auth['provider'] == 'linkedin'
      user = where(linkedin_id: auth['uid']).first_or_create
      raw_info = auth['extra']['raw_info']
      #logger.debug JSON.pretty_generate(JSON.parse(auth.to_json))
      user.linkedin_data = {
        name:        [raw_info['firstName'], raw_info['lastName']].reject(&:blank?).join(' ').squish,
        headline:    raw_info['headline'],
        photo_url:   raw_info['pictureUrl'],
        profile_url: raw_info['publicProfileUrl'],
        location:    raw_info['location']['name'],
        industry:    raw_info['industry']
      }
      user.name  ||= user.linkedin_data[:name]
      user.save!
      user
    else
      raise 'Invalid oAuth provider'
    end
  end
end
