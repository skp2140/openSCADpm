class Package < ApplicationRecord
  before_save { self.link = link.downcase }
  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
  validates :link, presence: true, length: { maximum: 200},
                   uniqueness: { case_sensitive: false }
  validates :package_info, presence: true, length: { minimum: 50 }

end
