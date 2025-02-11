class Spp < ApplicationRecord
  belongs_to :siswa
  belongs_to :kela, foreign_key: 'kelas_id', optional: true  # Tambahkan optional: true jika kelas tidak wajib
  validates :biaya, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :tahun, presence: true
  validates :bulan, presence: true
  
end