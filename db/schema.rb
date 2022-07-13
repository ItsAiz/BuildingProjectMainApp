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

ActiveRecord::Schema[7.0].define(version: 2022_07_12_212144) do
  create_table "propietarios", primary_key: "ID", id: { type: :string, limit: 15 }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "TipoID", limit: 5, null: false
    t.string "Nombres", limit: 30, null: false
    t.string "Apellidos", limit: 30, null: false
    t.string "Correo", limit: 50, null: false
    t.string "Telefono", limit: 15, null: false
    t.string "Contraseña", limit: 20, null: false
    t.bigint "user_id"
    t.index ["Correo"], name: "Correo", unique: true
    t.index ["Telefono"], name: "Telefono", unique: true
    t.index ["user_id"], name: "index_propietarios_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "documentNumber", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "propietarios", "users"
end
