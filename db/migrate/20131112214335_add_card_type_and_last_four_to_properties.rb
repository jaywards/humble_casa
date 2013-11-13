class AddCardTypeAndLastFourToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :card_type, :string
    add_column :properties, :last_four, :string
  end
end
