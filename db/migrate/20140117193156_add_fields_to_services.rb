class AddFieldsToServices < ActiveRecord::Migration
  def change
    add_column :services, :terms_agreement, :boolean, default: true
  end
end
