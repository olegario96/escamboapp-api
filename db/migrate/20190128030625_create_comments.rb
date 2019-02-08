class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :title
      t.string :description
      t.decimal :rating
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
