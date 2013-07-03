class AddColumnCompletionNotesToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :completion_note, :string
  end
end
