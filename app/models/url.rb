require 'base64'
require 'open-uri'
require 'net/http'
class Url < ActiveRecord::Base
  # Remember to create a migration!
  validates_presence_of :full_url
  validate :valid_uri_and_response
  validates :full_url, :format => { with: /(http:\/\/|https:\/\/).+/ }

  before_save :create_short_url
  


  def create_short_url
    self.short_url = Base64.encode64(self.full_url)[13..17]
  end

  def valid_uri_and_response
    @uri = URI::parse(self.full_url)
    Net::HTTP.get_response(@uri).code == "200"
  rescue
    return false
  end

end


