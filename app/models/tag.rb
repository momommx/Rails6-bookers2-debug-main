class Tag < ApplicationRecord
  validates :tagname, uniqueness: true
  has_many :tag_relations
  has_many :books, through: :tag_relations
end
