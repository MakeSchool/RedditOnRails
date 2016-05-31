# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160222232022) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "url"
    t.integer  "subreddit_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "articles", ["subreddit_id"], name: "index_articles_on_subreddit_id"
  add_index "articles", ["title"], name: "index_articles_on_title"
  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id"
  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "moderators", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subreddit_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "moderators", ["subreddit_id"], name: "index_moderators_on_subreddit_id"
  add_index "moderators", ["user_id"], name: "index_moderators_on_user_id"

  create_table "subreddits", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "slug"
  end

  add_index "subreddits", ["slug"], name: "index_subreddits_on_slug", unique: true
  add_index "subreddits", ["title"], name: "index_subreddits_on_title", unique: true
  add_index "subreddits", ["user_id"], name: "index_subreddits_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["article_id"], name: "index_votes_on_article_id"

end
