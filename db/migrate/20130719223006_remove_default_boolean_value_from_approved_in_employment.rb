class RemoveDefaultBooleanValueFromApprovedInEmployment < ActiveRecord::Migration
    def change
        change_column :employments, :approved, :boolean
    end
end
