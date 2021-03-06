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

ActiveRecord::Schema.define(version: 20161228135019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"
  enable_extension "hstore"

  create_table "connections", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.boolean  "importing",    default: false
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "developer_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["developer_id"], name: "index_connections_on_developer_id", using: :btree
    t.index ["uid", "provider", "developer_id"], name: "index_connections_on_uid_and_provider_and_developer_id", unique: true, using: :btree
  end

  create_table "developers", force: :cascade do |t|
    t.string   "login",               default: "",    null: false
    t.string   "avatar",              default: ""
    t.string   "name",                default: "",    null: false
    t.string   "email",               default: "",    null: false
    t.text     "bio"
    t.string   "linkedin",            default: ""
    t.string   "location",            default: ""
    t.string   "languages",           default: [],                 array: true
    t.boolean  "remote",              default: false
    t.boolean  "relocate",            default: false
    t.boolean  "hireable",            default: false
    t.boolean  "premium",             default: false
    t.boolean  "part_time",           default: false
    t.boolean  "full_time",           default: false
    t.boolean  "contract",            default: false
    t.boolean  "freelance",           default: false
    t.boolean  "internship",          default: false
    t.boolean  "startup",             default: false
    t.boolean  "cto",                 default: false
    t.boolean  "lead",                default: false
    t.boolean  "senior",              default: false
    t.boolean  "mid",                 default: false
    t.boolean  "junior",              default: false
    t.boolean  "student",             default: false
    t.string   "encrypted_password",  default: "",    null: false
    t.jsonb    "data",                default: "{}",  null: false
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "remember_created_at"
    t.string   "blog"
    t.index ["contract"], name: "index_developers_on_contract", using: :btree
    t.index ["cto"], name: "index_developers_on_cto", using: :btree
    t.index ["data"], name: "index_developers_on_data", using: :gin
    t.index ["email"], name: "index_developers_on_email", unique: true, using: :btree
    t.index ["freelance"], name: "index_developers_on_freelance", using: :btree
    t.index ["full_time"], name: "index_developers_on_full_time", using: :btree
    t.index ["hireable"], name: "index_developers_on_hireable", using: :btree
    t.index ["internship"], name: "index_developers_on_internship", using: :btree
    t.index ["junior"], name: "index_developers_on_junior", using: :btree
    t.index ["languages"], name: "index_developers_on_languages", using: :gin
    t.index ["lead"], name: "index_developers_on_lead", using: :btree
    t.index ["location"], name: "index_developers_on_location", using: :btree
    t.index ["login"], name: "index_developers_on_login", unique: true, using: :btree
    t.index ["mid"], name: "index_developers_on_mid", using: :btree
    t.index ["part_time"], name: "index_developers_on_part_time", using: :btree
    t.index ["premium"], name: "index_developers_on_premium", using: :btree
    t.index ["relocate"], name: "index_developers_on_relocate", using: :btree
    t.index ["remote"], name: "index_developers_on_remote", using: :btree
    t.index ["senior"], name: "index_developers_on_senior", using: :btree
    t.index ["startup"], name: "index_developers_on_startup", using: :btree
    t.index ["student"], name: "index_developers_on_student", using: :btree
  end

  create_table "employers", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "login",                  default: "",    null: false
    t.text     "bio",                    default: "",    null: false
    t.string   "avatar",                 default: "",    null: false
    t.string   "name",                   default: "",    null: false
    t.boolean  "verified",               default: false
    t.string   "company",                default: "",    null: false
    t.string   "website",                default: "",    null: false
    t.jsonb    "preferences",            default: "{}",  null: false
    t.string   "access_token",           default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_employers_on_email", unique: true, using: :btree
    t.index ["login"], name: "index_employers_on_login", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_employers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "favourites", force: :cascade do |t|
    t.string   "login"
    t.integer  "developer_id"
    t.integer  "employer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["developer_id"], name: "index_favourites_on_developer_id", using: :btree
    t.index ["employer_id"], name: "index_favourites_on_employer_id", using: :btree
    t.index ["login", "developer_id", "employer_id"], name: "index_favourites_on_login_and_developer_id_and_employer_id", unique: true, using: :btree
    t.index ["login"], name: "index_favourites_on_login", using: :btree
  end

  create_table "imports", force: :cascade do |t|
    t.string   "source_id"
    t.string   "source_name"
    t.jsonb    "data"
    t.boolean  "pinned",        default: false
    t.integer  "connection_id"
    t.integer  "developer_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "category"
    t.index ["category"], name: "index_imports_on_category", using: :btree
    t.index ["connection_id"], name: "index_imports_on_connection_id", using: :btree
    t.index ["data"], name: "index_imports_on_data", using: :gin
    t.index ["developer_id"], name: "index_imports_on_developer_id", using: :btree
    t.index ["pinned"], name: "achievements", where: "(pinned = true)", using: :btree
    t.index ["pinned"], name: "index_imports_on_pinned", using: :btree
    t.index ["source_id"], name: "index_imports_on_source_id", using: :btree
    t.index ["source_name", "source_id", "connection_id", "category"], name: "unique_import_per_category_and_source", unique: true, using: :btree
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.string  "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",        default: ""
    t.integer  "messages_count"
    t.integer  "receipts_count"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.integer  "receipts_count"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.string   "notified_object_type"
    t.integer  "notified_object_id"
    t.string   "message_object_type"
    t.integer  "message_object_id"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
    t.index ["message_object_type", "message_object_id"], name: "mailboxer_message_object", using: :btree
    t.index ["notification_code"], name: "index_mailboxer_notifications_on_notification_code", using: :btree
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
    t.index ["notified_object_type", "notified_object_id"], name: "mailboxer_notified_object", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
    t.index ["type"], name: "index_mailboxer_notifications_on_type", using: :btree
  end

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.integer  "notification_id",                                null: false
    t.boolean  "is_read",                        default: false
    t.boolean  "trashed",                        default: false
    t.boolean  "deleted",                        default: false
    t.string   "mailbox_type",        limit: 25
    t.integer  "messages_count"
    t.integer  "notifications_count"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "is_delivered",                   default: false
    t.boolean  "is_rejected",                    default: false
    t.boolean  "is_spam",                        default: false
    t.boolean  "is_replied",                     default: false
    t.string   "delivery_method"
    t.string   "message_id"
    t.index ["deleted"], name: "deleted_receipts", where: "(deleted = true)", using: :btree
    t.index ["is_read"], name: "read_receipts", where: "(is_read = true)", using: :btree
    t.index ["is_read"], name: "unread_receipts", where: "(is_read = false)", using: :btree
    t.index ["mailbox_type", "trashed", "deleted"], name: "all_inbox_receipts", where: "(((mailbox_type)::text = 'inbox'::text) AND (trashed = false) AND (deleted = false))", using: :btree
    t.index ["mailbox_type", "trashed", "deleted"], name: "all_sentbox_receipts", where: "(((mailbox_type)::text = 'sentbox'::text) AND (trashed = false) AND (deleted = false))", using: :btree
    t.index ["mailbox_type"], name: "inbox_receipts", where: "((mailbox_type)::text = 'inbox'::text)", using: :btree
    t.index ["mailbox_type"], name: "sent_receipts", where: "((mailbox_type)::text = 'sentbox'::text)", using: :btree
    t.index ["mailbox_type"], name: "trashed_receipts", where: "((trashed = true) AND (deleted = false))", using: :btree
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree
    t.index ["trashed"], name: "not_trashed_receipts", where: "(trashed = false)", using: :btree
  end

  create_table "que_jobs", primary_key: ["queue", "priority", "run_at", "job_id"], force: :cascade, comment: "3" do |t|
    t.integer   "priority",    limit: 2, default: 100,            null: false
    t.datetime  "run_at",                default: -> { "now()" }, null: false
    t.bigserial "job_id",                                         null: false
    t.text      "job_class",                                      null: false
    t.json      "args",                  default: [],             null: false
    t.integer   "error_count",           default: 0,              null: false
    t.text      "last_error"
    t.text      "queue",                 default: "",             null: false
  end

  create_table "searches", force: :cascade do |t|
    t.hstore   "params"
    t.integer  "employer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["employer_id"], name: "index_searches_on_employer_id", using: :btree
    t.index ["params"], name: "index_searches_on_params", using: :gin
  end

  add_foreign_key "connections", "developers"
  add_foreign_key "favourites", "employers"
  add_foreign_key "imports", "connections"
  add_foreign_key "imports", "developers"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "searches", "employers"
end
