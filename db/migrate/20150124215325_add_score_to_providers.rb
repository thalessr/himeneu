class AddScoreToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :score, :decimal, :precision => 3, :scale => 2
  end
end
