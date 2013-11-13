class ChangeAcceptCcInServices < ActiveRecord::Migration
	remove_column :services, :accept_cc
	add_column :services, :accept_cc, :boolean
end
