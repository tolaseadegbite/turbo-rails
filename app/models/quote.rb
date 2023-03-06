class Quote < ApplicationRecord
    belongs_to :company
    validates :name, presence: true
    scope :ordered, -> { order(id: :desc) }

    has_many :line_item_dates, dependent: :destroy
    has_many :line_items, through: :line_item_dates

    # after_create_commit -> { broadcast_prepend_later_to "quotes" }
    # after_update_commit -> { broadcast_replace_later_to "quotes" }
    # after_destroy_commit -> { broadcast_remove_later_to "quotes" }

    # The above lines is equivalent to the below line.
    broadcasts_to -> (quote) { [quote.company, "quotes"] }, inserts_by: :prepend

    def total_price
        line_items.sum(&:total_price)
    end
end
