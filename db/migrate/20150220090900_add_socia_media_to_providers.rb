class AddSociaMediaToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :video_url, :string
    add_column :providers, :facebook, :string
    add_column :providers, :twitter, :string, :limit => 100
    add_column :providers, :instagram, :string
    add_column :providers, :website, :string
  end
end
