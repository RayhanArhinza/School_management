class Gender < ApplicationRecord
    has_many :gurus, foreign_key: 'jenis_kelamin'
    has_many :siswas, foreign_key: 'jenis_kelamin'
  end