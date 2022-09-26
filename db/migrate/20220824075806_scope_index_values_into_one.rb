# frozen_string_literal: true

class ScopeIndexValuesIntoOne < ActiveRecord::Migration[7.0]
  def change
    remove_index :list_items, name: 'index_list_items_on_book_id'
    remove_index :list_items, name: 'index_list_items_on_user_id'

    add_index(:list_items, %i[user_id book_id], unique: true)
  end
end
