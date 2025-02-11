class Peminjam < ApplicationRecord
  belongs_to :buku
  belongs_to :siswa

  # Definisikan enum untuk status
  enum :status, { not_returned: 'Not returned yet', returned: 'Already returned' }

  # Validasi untuk memastikan tanggal_pinjam dan tanggal_kembali tidak kosong
  validates :tanggal_pinjam, presence: true
  # Validasi status untuk memastikan hanya status yang valid yang bisa dipilih
  validates :status, inclusion: { in: statuses.keys }

  # Opsional: Menambahkan metode untuk memudahkan perubahan status
  def mark_as_returned
    update(status: 'returned', tanggal_kembali: Date.today)
  end
end
