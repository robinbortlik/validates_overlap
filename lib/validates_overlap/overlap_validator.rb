require 'active_support/i18n'
I18n.load_path << File.dirname(__FILE__) + '/locale/en.yml'

class OverlapValidator < ActiveModel::EachValidator

  attr_accessor :sql_conditions
  attr_accessor :sql_values

  def initialize(args)
    attributes_are_range(args[:attributes])
    super
  end

  def validate(record)
    record.errors.add(attributes.first, :overlap) if self.find_crossed(record)
  end


  protected

  # Check if exists at least one record in DB which is crossed with current record
  def find_crossed(record)
    self.generate_overlap_sql_conditions(record)
    self.generate_overlap_sql_values(record)
    self.add_attributes(record, options[:scope]) if options && !(scope = options[:scope]).blank?

    return record.class.exists?([sql_conditions, sql_values])
  end


  # Resolve attributes values from record to use in sql conditions
  # return array in form ['2011-01-10', '2011-02-20']
  def resolve_values_from_attributes(record)
    attributes.map { |attr| record.send(attr.to_sym) }
  end

  # Prepare attribute names to use in sql conditions
  # return array in form ['meetings.starts_at', 'meetings.ends_at']
  def attributes_to_sql(record)
    attributes.map { |attr| attribute_to_sql(attr, record) }
  end


  # Prepare attribute name to use in sql conditions created in form 'table_name.attribute_name'
  def attribute_to_sql(attr, record)
    "#{record_table_name(record)}.#{attr}"
  end


  # Get the table name for the record
  def record_table_name(record)
    record.class.table_name
  end


  # Check if the validation of time range is defined by 2 attributes
  def attributes_are_range(attributes)
    raise "Validation of time range must be defined by 2 attributes" unless attributes.size == 2
  end


  # Generate sql condition for time range cross
  def generate_overlap_sql_conditions(record)
    starts_at_attr, ends_at_attr = attributes_to_sql(record)
    main_condition = condition_string(starts_at_attr, ends_at_attr)
    if record.new_record?
      self.sql_conditions = main_condition
    else
      self.sql_conditions = "#{main_condition} AND #{record_table_name(record)}.id != #{record.id}"
    end
  end


  # Return hash of values for overlap sql condition
  def generate_overlap_sql_values(record)
    starts_at_value, ends_at_value = resolve_values_from_attributes(record)
    self.sql_values = {:starts_at_value => starts_at_value, :ends_at_value => ends_at_value}
  end
  
  # Return the condition string depend on exclude_edges option.
  def condition_string(starts_at_attr, ends_at_attr)
    except_option = Array(options[:exclude_edges]).map(&:to_s)
    starts_at_sign = except_option.include?(starts_at_attr.split(".").last) ? "<" : "<="  
    ends_at_sign = except_option.include?(ends_at_attr.split(".").last) ? ">" : ">="
    "#{ends_at_attr} #{ends_at_sign} :starts_at_value AND #{starts_at_attr} #{starts_at_sign} :ends_at_value"
  end


  # Add attributes and values to sql conditions.
  # helps to use with scope options, so scope can be added as this forms :scope => "user_id" or :scope => ["user_id", "place_id"]
  def add_attributes(record, attrs)
    if attrs.is_a?(Array)
      attrs.each { |attr| self.add_attribute(record, attr) }
    else
      self.add_attribute(record, attrs)
    end
  end


  # Add attribute and his value to sql condition
  def add_attribute(record, attr)
    self.sql_conditions += " AND #{attribute_to_sql(attr, record)} = :#{attr}_value"
    self.sql_values.merge!({:"#{attr}_value" => record.send(:"#{attr}")})
  end

end
