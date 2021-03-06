class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
 #ここからフォロー関係
 has_many :relationships
 has_many :followings, through: :relationships, source: :follow
 has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
 has_many :followers, through: :reverse_of_relationships, source: :user

 # dm機能
 has_many :messages, dependent: :destroy
 has_many :entries, dependent: :destroy



  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  


  attachment :profile_image

  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
