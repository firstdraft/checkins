# frozen_string_literal: true

json.array! @check_ins, partial: 'check_ins/check_in', as: :check_in
