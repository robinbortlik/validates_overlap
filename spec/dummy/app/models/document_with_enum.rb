class DocumentWithEnum < ActiveRecord::Base
  self.table_name = 'documents_with_enum'

  enum kind: [:contract, :fact, :draft]

  validates :valid_from, :valid_until, overlap: {
    exclude_edges: ['valid_from', 'valid_until'],
    scope: ['kind']
  }
end
