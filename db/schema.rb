# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081219091142) do

  create_table "addresses", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zipcode"
    t.integer  "country_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "state_name"
  end

  create_table "assets", :force => true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.string   "attachment_content_type"
    t.string   "attachment_file_name"
    t.integer  "attachment_size"
    t.integer  "position"
    t.string   "type"
    t.datetime "attachment_updated_at"
  end

  create_table "configurations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "countries", :force => true do |t|
    t.string  "iso_name"
    t.string  "iso"
    t.string  "name"
    t.string  "iso3"
    t.integer "numcode"
  end

  create_table "creditcard_payments", :force => true do |t|
    t.integer  "order_id"
    t.string   "number"
    t.string   "cc_type"
    t.string   "month"
    t.string   "year"
    t.string   "display_number"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "creditcard_txns", :force => true do |t|
    t.integer  "creditcard_payment_id"
    t.decimal  "amount",                :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.string   "txn_type"
    t.string   "response_code"
    t.text     "avs_response"
    t.text     "cvv_response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gateway_configurations", :force => true do |t|
    t.integer  "gateway_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gateway_option_values", :force => true do |t|
    t.integer  "gateway_configuration_id"
    t.integer  "gateway_option_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gateway_options", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "gateway_id"
    t.boolean  "textarea",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gateways", :force => true do |t|
    t.string   "clazz"
    t.string   "name"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_units", :force => true do |t|
    t.integer  "variant_id"
    t.integer  "order_id"
    t.string   "state"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "variant_id"
    t.integer  "quantity",                                 :null => false
    t.decimal  "price",      :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "option_types", :force => true do |t|
    t.string   "name",         :limit => 100
    t.string   "presentation", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "option_values", :force => true do |t|
    t.integer  "option_type_id"
    t.string   "name"
    t.integer  "position"
    t.string   "presentation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "option_values_variants", :id => false, :force => true do |t|
    t.integer "variant_id"
    t.integer "option_value_id"
  end

  add_index "option_values_variants", ["variant_id"], :name => "index_option_values_variants_on_variant_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "number",               :limit => 15
    t.decimal  "ship_amount",                        :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "tax_amount",                         :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "item_total",                         :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.decimal  "total",                              :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.string   "ip_address"
    t.text     "special_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.boolean  "checkout_complete"
  end

  create_table "preferences", :force => true do |t|
    t.string   "attribute",  :null => false
    t.integer  "owner_id",   :null => false
    t.string   "owner_type", :null => false
    t.integer  "group_id"
    t.string   "group_type"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["owner_id", "owner_type", "attribute", "group_id", "group_type"], :name => "index_preferences_on_owner_and_attribute_and_preference", :unique => true

  create_table "product_option_types", :force => true do |t|
    t.integer  "product_id"
    t.integer  "option_type_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_properties", :force => true do |t|
    t.integer  "product_id"
    t.integer  "property_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name",                                               :default => "", :null => false
    t.text     "description"
    t.decimal  "master_price",         :precision => 8, :scale => 2
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.datetime "available_on"
    t.integer  "tax_category_id"
    t.datetime "deleted_at"
    t.integer  "shipping_category_id"
  end

  add_index "products", ["permalink"], :name => "index_products_on_permalink"
  add_index "products", ["available_on"], :name => "index_products_on_available_on"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["deleted_at"], :name => "index_products_on_deleted_at"

  create_table "products_taxons", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "taxon_id"
  end

  add_index "products_taxons", ["product_id"], :name => "index_products_taxons_on_product_id"
  add_index "products_taxons", ["taxon_id"], :name => "index_products_taxons_on_taxon_id"

  create_table "properties", :force => true do |t|
    t.string   "name"
    t.string   "presentation", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties_prototypes", :id => false, :force => true do |t|
    t.integer "prototype_id"
    t.integer "property_id"
  end

  create_table "prototypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "shipments", :force => true do |t|
    t.integer  "order_id"
    t.integer  "shipping_method_id"
    t.string   "tracking"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_methods", :force => true do |t|
    t.integer  "zone_id"
    t.string   "shipping_calculator"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "state_events", :force => true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string  "name"
    t.string  "abbr"
    t.integer "country_id"
  end

  create_table "tax_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_rates", :force => true do |t|
    t.integer  "zone_id"
    t.decimal  "amount",          :precision => 8, :scale => 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_type"
    t.integer  "tax_category_id"
  end

  create_table "taxonomies", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxons", :force => true do |t|
    t.integer  "taxonomy_id",                :null => false
    t.integer  "parent_id"
    t.integer  "position",    :default => 0
    t.string   "name",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.string   "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variants", :force => true do |t|
    t.integer  "product_id"
    t.string   "sku",                                      :default => "", :null => false
    t.decimal  "price",      :precision => 8, :scale => 2,                 :null => false
    t.datetime "deleted_at"
    t.decimal  "weight",     :precision => 8, :scale => 2
    t.decimal  "height",     :precision => 8, :scale => 2
    t.decimal  "width",      :precision => 8, :scale => 2
    t.decimal  "depth",      :precision => 8, :scale => 2
  end

  add_index "variants", ["product_id"], :name => "index_variants_on_product_id"

  create_table "zone_members", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "member_id"
    t.string   "member_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
