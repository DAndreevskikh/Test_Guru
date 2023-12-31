class User < ApplicationRecord
  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id'

  validates :email, presence: true

  def tests_by_level(level)
    tests.where(level: level)
  end
end
