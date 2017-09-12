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

ActiveRecord::Schema.define(version: 20170912164752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clazzs", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.integer "year", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_formats", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_course_formats_on_name"
  end

  create_table "course_modalities", force: :cascade do |t|
    t.string "sigla", limit: 5, null: false
    t.string "description", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_course_modalities_on_description"
  end

  create_table "course_offers", force: :cascade do |t|
    t.string "description", limit: 45, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "sigla", limit: 5, null: false
    t.boolean "active", default: true
    t.integer "carga_horaria", null: false
    t.bigint "course_modality_id"
    t.bigint "course_format_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_offer_id"
    t.index ["course_format_id"], name: "index_courses_on_course_format_id"
    t.index ["course_modality_id"], name: "index_courses_on_course_modality_id"
    t.index ["course_offer_id"], name: "index_courses_on_course_offer_id"
    t.index ["name"], name: "index_courses_on_name"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "title", limit: 45, null: false
    t.string "sigla", null: false
    t.boolean "active", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_disciplines_on_user_id"
  end

  create_table "grid_disciplines", force: :cascade do |t|
    t.integer "year", null: false
    t.text "ementa", null: false
    t.text "objetivo_geral", null: false
    t.text "bib_geral", null: false
    t.text "bib_espec", null: false
    t.bigint "grid_id"
    t.bigint "discipline_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discipline_id"], name: "index_grid_disciplines_on_discipline_id"
    t.index ["grid_id"], name: "index_grid_disciplines_on_grid_id"
  end

  create_table "grids", force: :cascade do |t|
    t.integer "year", null: false
    t.boolean "active", default: true
    t.bigint "course_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_grids_on_course_id"
    t.index ["user_id"], name: "index_grids_on_user_id"
  end

  create_table "perfil_roles", force: :cascade do |t|
    t.bigint "perfil_id"
    t.bigint "role_id"
    t.index ["perfil_id", "role_id"], name: "index_perfil_roles_on_perfil_id_and_role_id", unique: true
    t.index ["perfil_id"], name: "index_perfil_roles_on_perfil_id"
    t.index ["role_id"], name: "index_perfil_roles_on_role_id"
  end

  create_table "perfils", force: :cascade do |t|
    t.string "name", limit: 45, null: false
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
    t.string "name", limit: 45, null: false
    t.string "resource_type", limit: 100
    t.string "resource_id", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turmas", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.integer "year", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_turmas_on_name"
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
    t.string "username"
    t.boolean "teacher", default: false
    t.text "bio"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_perfils", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "perfil_id"
    t.index ["perfil_id", "user_id"], name: "index_users_perfils_on_perfil_id_and_user_id", unique: true
    t.index ["perfil_id"], name: "index_users_perfils_on_perfil_id"
    t.index ["user_id"], name: "index_users_perfils_on_user_id"
  end

  add_foreign_key "courses", "course_formats"
  add_foreign_key "courses", "course_modalities"
  add_foreign_key "courses", "course_offers"
  add_foreign_key "courses", "users"
  add_foreign_key "disciplines", "users"
  add_foreign_key "grid_disciplines", "disciplines"
  add_foreign_key "grid_disciplines", "grids"
  add_foreign_key "grids", "courses"
  add_foreign_key "grids", "users"
  add_foreign_key "perfil_roles", "perfils"
  add_foreign_key "perfil_roles", "roles"
  add_foreign_key "users_perfils", "perfils"
  add_foreign_key "users_perfils", "users"
end
