class CreateJetlyUrl < ActiveRecord::Migration
  def change
    create_table :jetly_urls do |t|
      t.string :complete_url, null: false, unique: true
      t.string :url_hash, null: false, unique: true
      t.integer :visits_count, null: false, default: 0

      t.timestamps
    end
  end
end
