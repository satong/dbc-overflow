class AddBestColumnToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :best, :integer, { default: 0 }
  end
end
