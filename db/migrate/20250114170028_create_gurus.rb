class CreateGurus < ActiveRecord::Migration[8.0]
  def change
    create_table :gurus do |t|
      t.integer :user_id
      t.string :NUPTK
      t.string :nik
      t.date :tanggal_lahir
      t.string :mata_pelajaran
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



