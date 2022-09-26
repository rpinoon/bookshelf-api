# frozen_string_literal: true

class CreateListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :list_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :rating, default: -1
      t.string :notes
      t.date :start_date
      t.date :finish_date

      t.timestamps
    end
  end
end
