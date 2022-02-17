class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :organizations, :bg_color, :color
    change_column_default :organizations, :color, from: "#c28e71", to: "#ffffff"
  end
end
