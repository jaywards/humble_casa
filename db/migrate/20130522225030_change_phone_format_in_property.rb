class ChangePhoneFormatInProperty < ActiveRecord::Migration
  def change
    change_column :properties, :phone, :string
  end
end
