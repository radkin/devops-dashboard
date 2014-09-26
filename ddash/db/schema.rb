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

ActiveRecord::Schema.define(version: 20140926220746) do

  create_table "builds", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gitlabs", force: true do |t|
    t.integer  "git_id"
    t.integer  "mr"
    t.string   "shas"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gitlabs", ["git_id"], name: "index_gitlabs_on_git_id", using: :btree

  create_table "gits", force: true do |t|
    t.string   "sha"
    t.string   "owner"
    t.string   "repo"
    t.string   "host"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jenkins", force: true do |t|
    t.integer  "masters_id"
    t.integer  "jenkins_jobs_id"
    t.integer  "slaves_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jenkins", ["jenkins_jobs_id"], name: "index_jenkins_on_jenkins_jobs_id", using: :btree
  add_index "jenkins", ["masters_id"], name: "index_jenkins_on_masters_id", using: :btree
  add_index "jenkins", ["slaves_id"], name: "index_jenkins_on_slaves_id", using: :btree

  create_table "jenkins_jobs", force: true do |t|
    t.string   "name"
    t.integer  "builds_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jenkins_jobs", ["builds_id"], name: "index_jenkins_jobs_on_builds_id", using: :btree

  create_table "jiras", force: true do |t|
    t.string   "ticket"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "masters", force: true do |t|
    t.string   "master"
    t.string   "url"
    t.integer  "total_success"
    t.integer  "total_failed"
    t.integer  "slaves_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "masters", ["slaves_id"], name: "index_masters_on_slaves_id", using: :btree

  create_table "slaves", force: true do |t|
    t.string   "slave"
    t.string   "url"
    t.integer  "masters_id"
    t.integer  "jenkins_jobs_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slaves", ["jenkins_jobs_id"], name: "index_slaves_on_jenkins_jobs_id", using: :btree
  add_index "slaves", ["masters_id"], name: "index_slaves_on_masters_id", using: :btree

  create_table "train_routes", force: true do |t|
    t.string   "jira_tickets"
    t.string   "jenkins_jobs"
    t.integer  "gitlab_mrs"
    t.datetime "created"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trains", force: true do |t|
    t.string   "git_commit"
    t.integer  "jenkins_id"
    t.integer  "svn_id"
    t.integer  "git_id"
    t.integer  "gerrit_id"
    t.integer  "gitlab_id"
    t.integer  "jira_id"
    t.datetime "depart"
    t.datetime "arrive"
    t.integer  "train_route_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trains", ["gerrit_id"], name: "index_trains_on_gerrit_id", using: :btree
  add_index "trains", ["git_id"], name: "index_trains_on_git_id", using: :btree
  add_index "trains", ["gitlab_id"], name: "index_trains_on_gitlab_id", using: :btree
  add_index "trains", ["jenkins_id"], name: "index_trains_on_jenkins_id", using: :btree
  add_index "trains", ["jira_id"], name: "index_trains_on_jira_id", using: :btree
  add_index "trains", ["svn_id"], name: "index_trains_on_svn_id", using: :btree
  add_index "trains", ["train_route_id"], name: "index_trains_on_train_route_id", using: :btree

end
