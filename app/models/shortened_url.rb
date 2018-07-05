require 'byebug'

# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true
  
  # has_many :visitors,
  #   through:
  
  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit
  
  
  has_many :visitors,
    through: :visits,
    source: :user

    
  has_many :unique_visitors,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :user

  
  # has_many :visitors,
  #   primary_key: :id,
  #   foreign_key: :user_id,
  #   class_name: :Visit
  # 
  # has_many :distinct_visitors,
  #   Proc.new { distinct },
  #   primary_key: :id,
  #   foreign_key: :user_id,
  #   class_name: :Visit
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,  
    class_name: :User
  
  def self.random_code
    short_url = SecureRandom::urlsafe_base64(12)
    
  end
  
  def self.create_short_url(user, url)
    user_id = user.id
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!('user_id' => user_id, 'long_url' => url, 'short_url' => short_url)
  end
  
  def num_clicks
    self.visitors.count
  end
  
  def num_uniques
    debugger
    self.unique_visitors.count
  end
  
  def num_recent_uniques
    self.unique_visitors.where("created_at IS BETWEEN 2.hours.ago AND Time.now")
  end
end
