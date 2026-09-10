module RailsLts
  def self.configuration
    nil
  end
end

ActiveRecord::Base.yaml_column_permitted_classes |= [
  Symbol,
  Date,
  Time,
  DateTime,
  ActiveSupport::HashWithIndifferentAccess
]
