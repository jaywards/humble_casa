class AddColumnDescriptionToService < ActiveRecord::Migration
  def change
    add_column :services, :biz_description, :text
  end
end
