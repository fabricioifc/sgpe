# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170717200816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cursos", force: :cascade do |t|
    t.string "title"
    t.string "sigla"
    t.string "description"
    t.boolean "idativo", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cursos_on_user_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "title", limit: 45, null: false
    t.text "description", null: false
    t.boolean "active", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_disciplines_on_user_id"
  end

  create_table "perfil_roles", force: :cascade do |t|
    t.bigint "perfil_id"
    t.bigint "role_id"
    t.index ["perfil_id", "role_id"], name: "index_perfil_roles_on_perfil_id_and_role_id", unique: true
    t.index ["perfil_id"], name: "index_perfil_roles_on_perfil_id"
    t.index ["role_id"], name: "index_perfil_roles_on_role_id"
  end

  create_table "perfils", force: :cascade do |t|
    t.string "name"
    t.boolean "idativo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_perfils_on_name"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.string "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "avatar"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_perfils", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "perfil_id"
    t.index ["perfil_id", "user_id"], name: "index_users_perfils_on_perfil_id_and_user_id", unique: true
    t.index ["perfil_id"], name: "index_users_perfils_on_perfil_id"
    t.index ["user_id"], name: "index_users_perfils_on_user_id"
  end

  add_foreign_key "cursos", "users"
  add_foreign_key "disciplines", "users"
  add_foreign_key "perfil_roles", "perfils"
  add_foreign_key "perfil_roles", "roles"
  add_foreign_key "users_perfils", "perfils"
  add_foreign_key "users_perfils", "users"
end
