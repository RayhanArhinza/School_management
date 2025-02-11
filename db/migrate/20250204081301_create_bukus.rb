class CreateBukus < ActiveRecord::Migration[8.0]
  def change
    create_table :bukus do |t|
      t.string :judul
      t.string :isbn
      t.string :pengarang
      t.string :penerbit
      t.integer :tahun_terbit
      t.string :category

      t.timestamps
    end
  end
end
