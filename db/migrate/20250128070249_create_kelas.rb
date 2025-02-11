class CreateKelas < ActiveRecord::Migration[8.0]
  def change
    create_table :kelas do |t|
      t.string :nama_kelas
      t.integer :guru_id  # Ubah tipe data menjadi integer

      t.timestamps
    end

    # Tambahkan index untuk meningkatkan performa query
    add_index :kelas, :guru_id
  end
end