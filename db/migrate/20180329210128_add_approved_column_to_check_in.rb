# frozen_string_literal: true

class AddApprovedColumnToCheckIn < ActiveRecord::Migration[5.2]
  def change
    add_column :check_ins, :approved, :boolean, default: false
  end
end
