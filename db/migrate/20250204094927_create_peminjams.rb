class CreatePeminjams < ActiveRecord::Migration[8.0]
  def change
    create_table :peminjams do |t|
      t.references :buku, null: false, foreign_key: true
      t.references :siswa, null: false, foreign_key: true
      t.date :tanggal_pinjam
      t.date :tanggal_kembali
      t.string :status, default: 'Not returned yet' # Menambahkan kolom status dengan default 'Not returned yet'

      t.timestamps
    end
  end
end
