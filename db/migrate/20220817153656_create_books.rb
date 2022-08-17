class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :cover_image_url
      t.integer :page_count
      t.string :publisher
      t.text :synopsis
      
      t.timestamps
    end
  end
end
