class Tagihan < ApplicationRecord
    enum :status, { unpaid: 'unpaid', paid: 'paid' }
    
    validates :nama, :biaya, :tanggal_tempo, presence: true
    validates :status, inclusion: { in: statuses.keys }
    def mark_as_paid
        update(status: 'paid', tanggal_kembali: Date.today)
    end
end


