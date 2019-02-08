class AddPriceCentsToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :price_cents, :integer
  end
end
