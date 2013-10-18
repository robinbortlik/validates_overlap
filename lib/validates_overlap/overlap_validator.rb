require 'active_support/i18n'
I18n.load_path << File.dirname(__FILE__) + '/locale/en.yml'

class OverlapValidator < ActiveModel::EachValidator
  BEGIN_OF_UNIX_TIME = Time.at(-2147483648).to_datetime
  END_OF_UNIX_TIME = Time.at(2147483648).to_datetime

  attr_accessor :sql_conditions
  attr_accessor :sql_values
  attr_accessor :scoped_model

  def initialize(args)
    attributes_are_range(args[:attributes])
    super
  end

  def validate(record)
    if self.find_crossed(record)
      if record.respond_to? attributes.first
        record.errors.add(options[:message_title] || attributes.first, options[:message_content] || :overlap)
      else
        record.errors.add(options[:message_title] || :base, options[:message_content] || :overlap)
      end
    end
  end


  protected

  # Check if exists at least one record in DB which is crossed with current record
  def find_crossed(record)
    self.scoped_model = record.class
    self.generate_overlap_sql_values(record)
    self.generate_overlap_sql_conditions(record)
    self.add_attributes(record, options[:scope]) if options && options[:scope].present?
    self.add_query_options(options[:query_options]) if options && options[:query_options].present?

    return self.scoped_model.exists?([sql_conditions, sql_values])
  end


  # Resolve attributes values from record to use in sql conditions
  # return array in form ['2011-01-10', '2011-02-20']
  def resolve_values_from_attributes(record)
    attributes.map do |attr|
      if attr.to_s.include?(".")
        self.get_assoc_value(record, attr)
      else
        record.send(attr.to_sym)
      end
    end
  end

  def get_assoc_value(record, attr)
    assoc, attr_name = attr.to_s.split(".")
    assoc_name = assoc.singularize.to_sym
    assoc_obj = record.send(assoc_name) if record.respond_to?(assoc_name)
    (assoc_obj || record).send(attr_name.to_sym)
  end
  # Prepare attribute names to use in sql conditions
  # return array in form ['meetings.starts_at', 'meetings.ends_at']
  def attributes_to_sql(record)
    attributes.map { |attr| attribute_to_sql(attr, record) }
  end


  # Prepare attribute name to use in sql conditions created in form 'table_name.attribute_name'
  def attribute_to_sql(attr, record)
    if attr.to_s.include?(".")
      attr
    else
      "#{record_table_name(record)}.#{attr}"
    end
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
    self.sql_values = {:starts_at_value => starts_at_value || BEGIN_OF_UNIX_TIME, :ends_at_value => ends_at_value || END_OF_UNIX_TIME}
  end

  # Return the condition string depend on exclude_edges option.
  def condition_string(starts_at_attr, ends_at_attr)
    except_option = Array(options[:exclude_edges]).map(&:to_s)
    starts_at_sign = except_option.include?(starts_at_attr.to_s.split(".").last) ? "<" : "<="
    ends_at_sign = except_option.include?(ends_at_attr.to_s.split(".").last) ? ">" : ">="
    query = []
    query << "(#{ends_at_attr} IS NULL OR #{ends_at_attr} #{ends_at_sign} :starts_at_value)"
    query << "(#{starts_at_attr} IS NULL OR #{starts_at_attr} #{starts_at_sign} :ends_at_value)"
    query.join(" AND ")
  end


  # Add attributes and values to sql conditions.
  # helps to use with scope options, so scope can be added as this forms :scope => "user_id" or :scope => ["user_id", "place_id"]
  def add_attributes(record, attrs)
    if attrs.is_a?(Array)
      attrs.each { |attr| self.add_attribute(record, attr) }
    elsif attrs.is_a?(Hash)
      attrs.each do |attr_name, value|
        self.add_attribute(record, attr_name, value)
      end
    else
      self.add_attribute(record, attrs)
    end
  end


  # Add attribute and his value to sql condition
  def add_attribute(record, attr_name, value = nil)
    _value = resolve_scope_value(record, attr_name, value)
    operator = _value.is_a?(Array) ? " IN (:%s)" : " = :%s"

    self.sql_conditions += " AND #{attribute_to_sql(attr_name, record)} #{operator}" % value_attribute_name(attr_name)
    self.sql_values.merge!({:"#{value_attribute_name(attr_name)}" => _value})
  end

  def value_attribute_name(attr_name)
    name = attr_name.to_s.include?(".") ? attr_name.to_s.gsub(".", "_") : attr_name
    name + "_value"
  end

  def resolve_scope_value(record, attr_name, value = nil)
    if value
      value.is_a?(Proc) ? value.call(record) : value
    else
      record.send(:"#{attr_name}")
    end
  end

  # Allow to use scope, joins, includes methods before querying
  # == Example:
  # validates_overlap :date_from, :date_to, :query_options => {:includes => "visits"}
  def add_query_options(methods)
    methods.each do |method_name, params|
      self.scoped_model = self.scoped_model.send(method_name.to_sym, *params)
    end
  end

end
