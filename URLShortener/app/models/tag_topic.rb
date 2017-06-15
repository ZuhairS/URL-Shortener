class TagTopic < ApplicationRecord
  validates :tag, presence: true, uniqueness: true

  has_many :taggings,
    class_name: "Tagging",
    foreign_key: :tag_id,
    primary_key: :id

  has_many :tagged_shortened_urls,
    through: :taggings,
    source: :tagged_shortened_url

  def popular_links
    # Visit.order('COUNT(user_id) DESC').group('short_url_id').limit(5)

    # tagged_shortened_urls.joins(:visits).order('COUNT(visits.user_id) DESC').group('short_url').limit(5)

    tagged_shortened_urls.joins(:visits).group('shortened_urls.id').order('COUNT(visits.id) DESC').select('long_url, short_url, COUNT(visits.id) AS num_visits')

    # sorted_urls = tagged_shortened_urls.sort_by do |short_url|
    #   short_url.num_clicks
    # end.reverse
    #
    # sorted_urls[0...5].map do |short_url|
    #   [short_url.short_url, short_url.num_clicks]
    # end
  end
end
