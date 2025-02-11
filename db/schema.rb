# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_10_135633) do
  create_table "bukus", force: :cascade do |t|
    t.string "judul"
    t.string "isbn"
    t.string "pengarang"
    t.string "penerbit"
    t.integer "tahun_terbit"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gurus", force: :cascade do |t|
    t.integer "user_id"
    t.string "NUPTK"
    t.string "nik"
    t.date "tanggal_lahir"
    t.string "mata_pelajaran"
    t.string "no_hp"
    t.text "alamat"
    t.string "email"
    t.date "tanggal_bergabung"
    t.integer "jenis_kelamin"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nama"
  end

  create_table "inventaris", force: :cascade do |t|
    t.string "nama"
    t.string "kepemilikan"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kelas", force: :cascade do |t|
    t.string "nama_kelas"
    t.integer "guru_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guru_id"], name: "index_kelas_on_guru_id"
  end

  create_table "peminjams", force: :cascade do |t|
    t.integer "buku_id", null: false
    t.integer "siswa_id", null: false
    t.date "tanggal_pinjam"
    t.date "tanggal_kembali"
    t.string "status", default: "Not returned yet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buku_id"], name: "index_peminjams_on_buku_id"
    t.index ["siswa_id"], name: "index_peminjams_on_siswa_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "siswas", force: :cascade do |t|
    t.string "name"
    t.string "nisn"
    t.string "nik"
    t.date "tanggal_lahir"
    t.string "kelas"
    t.string "no_hp"
    t.text "alamat"
    t.string "email"
    t.date "tanggal_bergabung"
    t.integer "jenis_kelamin"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kelas_id"
  end

  create_table "spps", force: :cascade do |t|
    t.integer "siswa_id", null: false
    t.integer "tahun"
    t.string "bulan"
    t.boolean "lunas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "biaya"
    t.integer "kelas_id"
    t.index ["siswa_id"], name: "index_spps_on_siswa_id"
  end

  create_table "tagihans", force: :cascade do |t|
    t.string "nama"
    t.integer "biaya"
    t.date "tanggal_tempo"
    t.date "tanggal_pembayaran"
    t.string "status", default: "unpaid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "peminjams", "bukus"
  add_foreign_key "peminjams", "siswas"
  add_foreign_key "spps", "siswas"
end
