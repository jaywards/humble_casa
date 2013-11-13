class AddLastFourAndCardTypeToServices < ActiveRecord::Migration
  def change
    add_column :services, :last_four, :string
    add_column :services, :card_type, :string
  end
end
