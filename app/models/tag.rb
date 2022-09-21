class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy, foreign_key: 'tag_id'
  has_many :books, through: :tag_relations

  scope :merge_books, -> (tags){ }
  
  def self.search_books_for(content, method)
    
    if method == 'perfect'
      tags = Tag.where(tagname: content) 
    elsif method == 'forward'
      tags = Tag.where('tagname LIKE ?', content + '%')
    elsif method == 'backward'
      tags = Tag.where('tagname LIKE ?', '%' + content)
    else
      tags = Tag.where('tagname LIKE ?', '%' + content + '%')
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.books}
    
  end
end