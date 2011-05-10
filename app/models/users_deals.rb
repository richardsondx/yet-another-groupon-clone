class UsersDeals < ActiveRecord::Base
  belongs_to :user
  belongs_to :deal
  
  def before_create
    self.promocode = Digest::SHA1.hexdigest(Time.now.to_s + promocode).slice(0..10)
  end
end
