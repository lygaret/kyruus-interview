class JSONSchemaValidator < ActiveModel::EachValidator
  def schema = @options # due to how the .validate method works

  def validate_each(record, attr, value)
    return if value.nil?

    errors = JSON::Validator.fully_validate(schema, value)
    errors.each do |err|
      record.errors.add attr, err
    end
  end
end
