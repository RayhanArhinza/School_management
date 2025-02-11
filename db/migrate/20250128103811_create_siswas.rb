class CreateSiswas < ActiveRecord::Migration[8.0]
  def change
    create_table :siswas do |t|
      t.string :name
      t.string :nisn
      t.string :nik
      t.date :tanggal_lahir
      t.string :kelas
      t.string :no_hp
      t.text :alamat
      t.string :email
      t.date :tanggal_bergabung
      t.integer :jenis_kelamin
      t.integer :role_id

      t.timestamps
    end
  end
end
