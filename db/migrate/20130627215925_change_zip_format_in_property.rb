class ChangeZipFormatInProperty < ActiveRecord::Migration
  def change
    change_column :properties, :zip, :string
  end
end
