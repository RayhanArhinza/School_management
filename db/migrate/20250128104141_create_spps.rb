class CreateSpps < ActiveRecord::Migration[8.0]
  def change
    create_table :spps do |t|
      t.references :siswa, null: false, foreign_key: true
      t.integer :tahun
      t.string :bulan
      t.boolean :lunas

      t.timestamps
    end
  end
end
