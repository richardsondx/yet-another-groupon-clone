class Deal < ActiveRecord::Base
  has_many :users_deals
  has_many :users, :through => :users_deals
  belongs_to :partner
  
  validates_presence_of :name, :description, :partner_id
  validates_numericality_of :price, :greater_than => 0
  validate :only_featured_for_given_period
  validate :start_in_future
  validate :finish_after_start
  validate :min_lenght_24_hours
  validate :partner_exists
  
  def before_validation
    if self.persisted? and self.start <= Time.now
      errors.add(:deal, "changes not allowed after deal start") 
      return false
    end
  end

  private
    def only_featured_for_given_period
      errors.add(:start, "there's already another featured deal for given period of time") if
        featured and
        ( Deal.where("featured = ? and start <= ? and  finish > ? and id != ?", true, start, start, id).count > 0 or
        Deal.where("featured = ? and start < ? and finish >= ? and id != ?", true, finish, finish, id).count > 0 )
    end
    
    def start_in_future
      errors.add(:start, "deal have to start minumum two hours from how") if
        start < Time.now + 2.hours
    end
    
    def finish_after_start
      errors.add(:finish, "deal end must be after start, and the deal must last for minimum of 24 hours") if
        (finish-start) < 0
    end
    
    def min_lenght_24_hours
      errors.add(:finish, "deal must last for at least 24 hours") unless
        (finish-start) > 24*60*60
    end
    
    def partner_exists
      begin
        Partner.find(partner_id) unless partner_id.nil?
      rescue
        errors.add(:partner_id, "doesn't exist")
      end
    end
end