class DashboardController < ApplicationController
    def index
      @gurus = Guru.includes(:user, :role, :gender)
      @kelas = Kela.includes(:guru, :siswas)
      @siswas = Siswa.includes(:role, :kela, :gender, :spps)
      @spps = Spp.all
      @inventaris = Inventari.all
      @tagihans = Tagihan.all
  
      # Menambahkan perhitungan jumlah
      @jumlah_siswa = @siswas.count
      @jumlah_guru = @gurus.count
      @jumlah_kelas = @kelas.count
      @jumlah_role = Role.count
      @jumlah_inventari = Inventari.sum(:total)
      @total_biaya_spp = Spp.sum(:biaya)
      @inventaris = Inventari.select(:nama, :total)
      @tagihans = Tagihan.select(:nama, :biaya, :tanggal_tempo)
    end
  end
  