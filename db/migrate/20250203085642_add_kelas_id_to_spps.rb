class AddKelasIdToSpps < ActiveRecord::Migration[8.0]
  def change
    add_column :spps, :kelas_id, :integer
  end
end
