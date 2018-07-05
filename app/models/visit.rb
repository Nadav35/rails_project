class Visit < ApplicationRecord
  
  validates :url_id, :user_id, presence: true
  
  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id
    
  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :url_id
  
  
  
  def self.record_visit!(user,shortened_url)
    Visit.create!(user_id: user.id, url_id: shortened_url.id)
  end
  
end