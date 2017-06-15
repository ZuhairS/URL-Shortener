class Tagging < ApplicationRecord
  validates :tag, :tagged_shortened_url, presence: true

  belongs_to :tag,
    class_name: "TagTopic",
    foreign_key: :tag_id,
    primary_key: :id

  belongs_to :tagged_shortened_url,
    class_name: "ShortenedUrl",
    foreign_key: :short_url_id,
    primary_key: :id
end
