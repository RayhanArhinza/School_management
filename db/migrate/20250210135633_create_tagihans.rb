class CreateTagihans < ActiveRecord::Migration[8.0]
  def change
    create_table :tagihans do |t|
      t.string :nama
      t.integer :biaya
      t.date :tanggal_tempo
      t.date :tanggal_pembayaran
      t.string :status, default: 'unpaid'

      t.timestamps
    end
  end
end
