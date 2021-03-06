class ShortenedUrl < ApplicationRecord
  belongs_to :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  has_many :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id

  has_many :taggings,
    class_name: "Tagging",
    foreign_key: :short_url_id,
    primary_key: :id

  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :submitter, presence: true

  def self.random_code
    short_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(['short_url = ?', short_url] )
      short_url = SecureRandom.urlsafe_base64
    end
    short_url
  end

  def self.create!(user, long_url)
    new_record = ShortenedUrl.new(long_url: long_url,
      short_url: ShortenedUrl.random_code,
      user_id: user.id)
    new_record.save
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.select(:user_id).count
  end

  def num_recent_uniques(time_start)
    visits.select(:user_id).where("created_at >= ?", time_start).distinct.count
  end

end
