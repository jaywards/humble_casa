class AddFieldsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :house_closing, :text
    add_column :properties, :house_closing_none, :boolean, default: false
    add_column :properties, :terms_agreement, :boolean, default: true
  end
end
