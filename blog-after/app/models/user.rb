class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    if auth['provider'] == 'linkedin'
      user = where(linkedin_id: auth['uid']).first_or_create
      raw_info = auth['extra']['raw_info']
      #logger.debug JSON.pretty_generate(JSON.parse(auth.to_json))
      user.linkedin_name        = [raw_info['firstName'], raw_info['lastName']].reject(&:blank?).join(' ').squish
      user.linkedin_email       = raw_info['emailAddress']
      user.linkedin_headline    = raw_info['headline']
      user.linkedin_photo_url   = raw_info['pictureUrl']
      user.linkedin_profile_url = raw_info['publicProfileUrl']
      user.linkedin_location    = raw_info['location']['name']
      user.linkedin_industry    = raw_info['industry']
      user.name  ||= user.linkedin_name
      user.email ||= user.linkedin_email
      user.save!
      user
    else
      raise 'Invalid oAuth provider'
    end
  end
end
