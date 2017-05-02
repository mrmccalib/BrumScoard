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

ActiveRecord::Schema.define(version: 20170425003808) do

  create_table "boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",        null: false
    t.string "description"
  end

  create_table "invitations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "board_id"
    t.integer "user_id"
    t.integer "role"
    t.index ["board_id", "user_id"], name: "index_invitations_on_board_id_and_user_id", using: :btree
  end

  create_table "memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "board_id"
    t.integer "user_id"
    t.integer "role"
    t.index ["board_id", "user_id"], name: "index_memberships_on_board_id_and_user_id", using: :btree
  end

  create_table "sprints", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at"
    t.integer  "board_id"
    t.index ["board_id"], name: "index_sprints_on_board_id", using: :btree
    t.index ["created_at"], name: "index_sprints_on_created_at", using: :btree
  end

  create_table "stories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "description"
    t.string  "as"
    t.string  "want"
    t.string  "so_that"
    t.string  "criteria"
    t.string  "size"
    t.integer "position"
    t.boolean "acceptance"
    t.string  "rejection_reason"
    t.integer "story_column_id"
    t.index ["position"], name: "index_stories_on_position", using: :btree
    t.index ["story_column_id"], name: "index_stories_on_story_column_id", using: :btree
  end

  create_table "story_columns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",      null: false
    t.integer "position"
    t.integer "sprint_id"
    t.index ["position"], name: "index_story_columns_on_position", using: :btree
    t.index ["sprint_id"], name: "index_story_columns_on_sprint_id", using: :btree
  end

  create_table "task_columns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",      null: false
    t.integer "position"
    t.integer "sprint_id"
    t.index ["position"], name: "index_task_columns_on_position", using: :btree
    t.index ["sprint_id"], name: "index_task_columns_on_sprint_id", using: :btree
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "description"
    t.integer "weight"
    t.integer "position"
    t.integer "task_column_id"
    t.integer "user_id"
    t.integer "story_id"
    t.index ["position"], name: "index_tasks_on_position", using: :btree
    t.index ["story_id"], name: "index_tasks_on_story_id", using: :btree
    t.index ["task_column_id"], name: "index_tasks_on_task_column_id", using: :btree
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username",        null: false
    t.string "first"
    t.string "last"
    t.string "password_digest"
  end

  add_foreign_key "sprints", "boards"
  add_foreign_key "stories", "story_columns"
  add_foreign_key "story_columns", "sprints"
  add_foreign_key "task_columns", "sprints"
  add_foreign_key "tasks", "stories"
  add_foreign_key "tasks", "task_columns"
  add_foreign_key "tasks", "users"
end
