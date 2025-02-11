class Buku < ApplicationRecord

  
    validates :judul, :isbn, :pengarang, :penerbit, :tahun_terbit, :category, presence: true
    validates :isbn, uniqueness: true
  end