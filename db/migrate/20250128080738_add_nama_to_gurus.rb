class AddNamaToGurus < ActiveRecord::Migration[8.0]
  def change
    add_column :gurus, :nama, :string
  end
end
