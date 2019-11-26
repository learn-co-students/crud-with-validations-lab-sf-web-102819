class Song < ApplicationRecord
    validates :title, presence: true
    validates :artist_name, presence: true
    validate :release_year_valid

    def release_year_valid
        if self.released
            if !self.release_year
                errors.add(:release_year, "need a release year if released")
            else 
                if self.release_year > 2019
                    errors.add(:release_year, "can't be later than current date")
                end
            end
            if Song.find_by(title: self.title) && Song.find_by(release_year: self.release_year)
                errors.add(:release_year, "can't release the same song")
            end
        end
    end
end
