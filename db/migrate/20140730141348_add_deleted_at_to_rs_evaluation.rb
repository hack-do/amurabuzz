class AddDeletedAtToRsEvaluation < ActiveRecord::Migration
  def change
    add_column :rs_evaluations, :deleted_at, :datetime
    add_index :rs_evaluations, :deleted_at
  end
end
