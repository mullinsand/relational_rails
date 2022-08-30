class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_exact(search_name)
    where(name: search_name)
  end
  
  def self.search_partial(search_name)
    where("name ILIKE ?", "%#{search_name}%")
  end
end
