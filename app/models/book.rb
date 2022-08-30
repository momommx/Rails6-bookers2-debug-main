class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  # 新着順, 星評価の高い順/ カラムデータの取り出し方を指示する記述
   scope :latest, -> {order(created_at: :desc)}
   scope :star_count, -> {order(rate: :desc)}
  
  # ★の評価機能
  validates :rate, numericality: {
  less_than_or_equal_to: 5,
  greater_than_or_equal_to: 1}, presence: true
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 検索方法の分岐を定義
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  # タグ検索
  def save_tags(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags
  
    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
   end
  end
end