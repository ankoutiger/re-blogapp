# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  #length
  validates :title, length: { minimum: 2 , maximum: 100 }
  validates :content, length:{ minimum:10 }

  validates :content, uniqueness: true
  validates :title, format: { with: /\A(?!\@)/ }

  validate :validate_title_and_content_length

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  

  def display_created_at
    I18n.l(created_at, format: :default)
  end

  def author_name
    user.display_name
  end

  private
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    unless char_count > 30
      errors.add(:content, '30文字以上で！')
    end
  end
end
