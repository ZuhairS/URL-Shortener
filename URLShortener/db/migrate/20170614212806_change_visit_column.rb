class ChangeVisitColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :visits, :short_url, :short_url_id
  end
end
