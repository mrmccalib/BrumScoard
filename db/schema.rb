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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20170228012320) do

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "username", null:false
    t.string   "password", null:false
    t.string   "first"
    t.string   "last"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
=======
ActiveRecord::Schema.define(version: 20170227022252) do

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "username", null: false
    t.string "password", null: false
>>>>>>> 1d41284de70d8c06ca24f72e194a2bddbe2c33fc
  end

end
