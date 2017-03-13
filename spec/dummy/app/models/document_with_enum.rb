class DocumentWithEnum < ActiveRecord::Base
  self.table_name = 'documents_with_enum'
  KINDS = [:contract, :fact, :draft]


  if (ActiveRecord::VERSION::MAJOR >= 5) || (ActiveRecord::VERSION::MAJOR > 4 && ActiveRecord::VERSION::MINOR > 1)
    enum kind: KINDS
  else
    # Simulate enum functionality implemented in rails 4.1 and 5
    # For rails version < 4.1 we always read read attribute by using read_attribute method
    def kind=(value)
      write_attribute(:kind, KINDS.index(value))
    end

    def kind
      return nil if read_attribute(:kind).nil?
      KINDS[read_attribute(:kind).to_i]
    end

  end

  validates :valid_from, :valid_until, overlap: {
    exclude_edges: ['valid_from', 'valid_until'],
    scope: ['kind']
  }
end
