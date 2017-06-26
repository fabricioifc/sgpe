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

ActiveRecord::Schema.define(version: 20170626133645) do

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

  create_table "perfil_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "perfil_id"
    t.index ["perfil_id"], name: "index_perfil_users_on_perfil_id"
    t.index ["user_id", "perfil_id"], name: "index_perfil_users_on_user_id_and_perfil_id", unique: true
    t.index ["user_id"], name: "index_perfil_users_on_user_id"
  end

  create_table "perfils", force: :cascade do |t|
    t.string "name"
    t.boolean "idativo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_perfils_on_name"
  end

  create_table "permissao_telas", force: :cascade do |t|
    t.bigint "permissao_id"
    t.bigint "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfil_id"], name: "index_permissao_telas_on_perfil_id"
    t.index ["permissao_id", "perfil_id"], name: "index_permissao_telas_on_permissao_id_and_perfil_id", unique: true
    t.index ["permissao_id"], name: "index_permissao_telas_on_permissao_id"
  end

  create_table "permissaos", force: :cascade do |t|
    t.string "name"
    t.string "classe"
    t.string "acao"
    t.boolean "idativo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["acao"], name: "index_permissaos_on_acao"
    t.index ["classe"], name: "index_permissaos_on_classe"
    t.index ["name"], name: "index_permissaos_on_name"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.string "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
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

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "cursos", "users"
  add_foreign_key "perfil_users", "perfils"
  add_foreign_key "perfil_users", "users"
  add_foreign_key "permissao_telas", "perfils"
  add_foreign_key "permissao_telas", "permissaos"
end
