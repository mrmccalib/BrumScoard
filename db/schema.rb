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

ActiveRecord::Schema.define(version: 20170402193444) do

  create_table "boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",        null: false
    t.string "description"
  end

  create_table "memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "board_id"
    t.integer "user_id"
    t.string  "role"
    t.index ["board_id", "user_id"], name: "index_memberships_on_board_id_and_user_id", using: :btree
  end

  create_table "stories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "description"
    t.string  "as"
    t.string  "want"
    t.string  "so_that"
    t.string  "criteria"
    t.string  "size"
    t.integer "position"
    t.integer "column"
    t.integer "board_id"
    t.index ["board_id"], name: "index_stories_on_board_id", using: :btree
    t.index ["position"], name: "index_stories_on_position", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username",        null: false
    t.string "first"
    t.string "last"
    t.string "password_digest"
  end

  add_foreign_key "stories", "boards"
end
