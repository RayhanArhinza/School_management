# app/models/kela.rb
class Kela < ApplicationRecord
    has_many :siswas, foreign_key: 'kelas_id'
    belongs_to :guru
  
    validates :nama_kelas, presence: true
  end
  