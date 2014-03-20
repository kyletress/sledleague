class Athlete < ActiveRecord::Base
  attr_accessible :name, :country
  has_many :results

  validates :name, presence: true

  def result(race_id)
  	r = Result.find_by_athlete_id_and_race_id(self.id, race_id)
     if r
       r.position
     else
       1000 # return a ridiculously high number, so we always have a result
     end
  end
  
  def has_result(race_id)
    result(race_id).exists?
  end
  
  def country_name
    c = ISO3166::Country[country]
    c.translations[I18n.locale.to_s] || country.name
  end

  def self.search(search)
  	if search
  		where('name LIKE ?', "%#{search}%")
  	else
  		scoped
  	end
  end
  
  # TODO add gender attribute. Shouldn't be able to predict men for a women's race
end
