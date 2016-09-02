module Datev
  class StringField < Field
    def limit
      options[:limit]
    end

    def validate!(value)
      super

      if value
        raise ArgumentError.new("Value given for field '#{name}' is not a String") unless value.is_a?(String)
        raise ArgumentError.new("Value '#{value}' for field '#{name}' is too long") if limit && value.length > limit
      end
    end

    def output(value)
      value = value || ""
      raise "Quotation marks in string field are not allowed, got: #{value}" if value.include?('"')
      '"' + value.slice(0, limit || 255) + '"'
    end
  end
end
