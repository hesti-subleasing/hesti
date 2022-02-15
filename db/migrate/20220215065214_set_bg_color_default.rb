class SetBgColorDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :organizations, :bg_color, from: nil, to: "#c28e71"
  end
end
