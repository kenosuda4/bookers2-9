class Room < ApplicationRecord
  # dm機能
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
end
