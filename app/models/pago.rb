class Pago < ApplicationRecord
    self.abstract_class = true
    connects_to database: {writing: :secondary, reading: :secondary}
    self.table_name = "pagos"
end
