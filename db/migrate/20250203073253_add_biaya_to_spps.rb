class AddBiayaToSpps < ActiveRecord::Migration[8.0]
  def change
    add_column :spps, :biaya, :integer
  end
end
