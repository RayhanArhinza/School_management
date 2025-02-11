class Inventari < ApplicationRecord
    validates :nama, :kepemilikan, :total, presence: true
    validates :total, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
  