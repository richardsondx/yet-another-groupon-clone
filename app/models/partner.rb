class Partner < ActiveRecord::Base
  has_many :deals
  
  def before_validation
    begin
      uri = URI.parse(url)
      p uri.normalize
    rescue => e
      p e
      errors.add(:url, 'Invalid url')
    end
  end
end
