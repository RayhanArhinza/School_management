class Siswa < ApplicationRecord
    has_many :spps, dependent: :destroy
    belongs_to :role
    belongs_to :kela, foreign_key: 'kelas_id'  # Foreign key updated
    belongs_to :gender, foreign_key: 'jenis_kelamin', optional: true
    validates :name, presence: true
    validates :kelas_id, presence: true

    after_create :generate_spp
  
    private
  
    def generate_spp
      current_year = Date.today.year
      (0..2).each do |year_offset| # Loop untuk 3 tahun
        tahun = current_year + year_offset
        (1..12).each do |bulan|
          spps.create(tahun: tahun, bulan: Date::MONTHNAMES[bulan], biaya: 0, lunas: false)
        end
      end
    end
  end
  