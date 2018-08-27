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

ActiveRecord::Schema.define(version: 2018_08_27_152656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coordenadors", force: :cascade do |t|
    t.string "funcao", null: false
    t.boolean "titular", default: true
    t.string "email", null: false
    t.boolean "responsavel", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id", null: false
    t.bigint "user_id"
    t.date "dtinicio"
    t.date "dtfim"
    t.index ["course_id"], name: "index_coordenadors_on_course_id"
    t.index ["user_id"], name: "index_coordenadors_on_user_id"
  end

  create_table "course_formats", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "minutos_aula"
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
    t.string "sigla", limit: 10, null: false
    t.boolean "active", default: true
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
    t.string "title", limit: 255, null: false
    t.string "sigla", null: false
    t.boolean "active", default: true
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "especial", default: false, null: false
    t.index ["user_id"], name: "index_disciplines_on_user_id"
  end

  create_table "grid_disciplines", force: :cascade do |t|
    t.integer "year"
    t.text "ementa"
    t.text "objetivo_geral"
    t.text "bib_geral"
    t.text "bib_espec"
    t.bigint "grid_id"
    t.bigint "discipline_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "semestre"
    t.integer "carga_horaria"
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
    t.boolean "enabled", default: true
    t.integer "carga_horaria"
    t.index ["course_id"], name: "index_grids_on_course_id"
    t.index ["user_id"], name: "index_grids_on_user_id"
  end

  create_table "offer_disciplines", force: :cascade do |t|
    t.bigint "grid_discipline_id"
    t.bigint "user_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "offer_id"
    t.integer "ead_percentual_maximo"
    t.integer "carga_horaria"
    t.bigint "second_user_id"
    t.index ["grid_discipline_id"], name: "index_offer_disciplines_on_grid_discipline_id"
    t.index ["offer_id"], name: "index_offer_disciplines_on_offer_id"
    t.index ["second_user_id"], name: "index_offer_disciplines_on_second_user_id"
    t.index ["user_id"], name: "index_offer_disciplines_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "year"
    t.integer "semestre"
    t.string "type_offer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.bigint "grid_id"
    t.integer "year_base"
    t.integer "semestre_base"
    t.string "turma"
    t.date "dtprevisao_entrega_plano"
    t.index ["grid_id"], name: "index_offers_on_grid_id"
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

  create_table "plans", force: :cascade do |t|
    t.bigint "offer_discipline_id"
    t.text "obj_espe"
    t.text "conteudo_prog"
    t.text "prat_prof"
    t.text "interdisc"
    t.text "met_tec"
    t.text "met_met"
    t.text "avaliacao"
    t.text "cronograma"
    t.text "atendimento"
    t.integer "versao"
    t.boolean "active"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "analise", default: false, null: false
    t.boolean "aprovado", default: false, null: false
    t.boolean "reprovado", default: false, null: false
    t.text "parecer"
    t.bigint "user_parecer_id"
    t.integer "ead_percentual_definido"
    t.text "observacoes"
    t.bigint "coordenador_id"
    t.index ["coordenador_id"], name: "index_plans_on_coordenador_id"
    t.index ["offer_discipline_id"], name: "index_plans_on_offer_discipline_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
    t.index ["user_parecer_id"], name: "index_plans_on_user_parecer_id"
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
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "siape"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
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

  add_foreign_key "coordenadors", "courses"
  add_foreign_key "coordenadors", "users"
  add_foreign_key "courses", "course_formats"
  add_foreign_key "courses", "course_modalities"
  add_foreign_key "courses", "course_offers"
  add_foreign_key "courses", "users"
  add_foreign_key "disciplines", "users"
  add_foreign_key "grid_disciplines", "disciplines"
  add_foreign_key "grid_disciplines", "grids"
  add_foreign_key "grids", "courses"
  add_foreign_key "grids", "users"
  add_foreign_key "offer_disciplines", "grid_disciplines"
  add_foreign_key "offer_disciplines", "offers"
  add_foreign_key "offer_disciplines", "users"
  add_foreign_key "offer_disciplines", "users", column: "second_user_id"
  add_foreign_key "offers", "grids"
  add_foreign_key "perfil_roles", "perfils"
  add_foreign_key "perfil_roles", "roles"
  add_foreign_key "plans", "coordenadors"
  add_foreign_key "plans", "offer_disciplines"
  add_foreign_key "plans", "users"
  add_foreign_key "users_perfils", "perfils"
  add_foreign_key "users_perfils", "users"
end
