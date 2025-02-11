class CreateInventaris < ActiveRecord::Migration[8.0]
  def change
    create_table :inventaris do |t|
      t.string :nama
      t.string :kepemilikan
      t.integer :total

      t.timestamps
    end
  end
end
