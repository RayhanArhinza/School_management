# app/models/role.rb
class Role < ApplicationRecord
    has_many :users
    has_many :gurus
    has_many :siswas
  end