# frozen_string_literal: true

class AddDefaultValueToScoreOnSubmission < ActiveRecord::Migration[5.2]
  def change
    change_column_default :submissions, :score, from: nil, to: 0.0
  end
end
