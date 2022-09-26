# frozen_string_literal: true

class RenameListItemsToUserBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :list_items, :rating, :integer, default: -1
    remove_column :list_items, :notes, :string
    add_column :list_items, :rating, :integer, default: 0
    add_column :list_items, :notes, :text
    rename_table :list_items, :user_books
  end
end
