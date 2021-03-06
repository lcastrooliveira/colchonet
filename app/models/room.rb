class Room < ActiveRecord::Base
  scope :most_recent, -> { order('created_at DESC') }

  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reviewed_rooms, through: :reviews, source: :room

  def complete_name
    "#{title}, #{location}"
  end
end
