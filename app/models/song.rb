class Song < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { 
    scope: :year,
    message: "cannot enter same artist in same year"
  }
  validates :released, inclusion: { in: [ true, false ] }
  validates :artist_name, presence: true

  with_options if: :released? do |r|
    r.validates :release_year, presence: true
    r.validates :release_year, numericality: {
      only_integer: true,
      less_than_or_equal_to: Date.current.year
     }
  end

  def released?
    released
  end
end
