# Di model Guru
class Guru < ApplicationRecord
    belongs_to :user
    belongs_to :role
    belongs_to :gender, foreign_key: 'jenis_kelamin', optional: true
    before_validation :set_email_from_user
  
    validates :NUPTK, presence: true, uniqueness: true
    validates :nik, presence: true, uniqueness: true
    validates :tanggal_lahir, presence: true
    validates :mata_pelajaran, presence: true
    validates :no_hp, presence: true
    validates :alamat, presence: true
    validates :email, presence: true, uniqueness: true
    validates :tanggal_bergabung, presence: true
    validates :role_id, presence: true
  
    def set_email_from_user
      self.email = user.email if user
    end
  
    # Menambahkan metode untuk mengambil nama dari User
    def nama
      user.name if user
    end
  end
  