module Datev
  class DateField < Field
    def format
      options[:format]
    end

    def validate!(value)
      super

      if value
        raise ArgumentError.new("Value given for field '#{name}' is not a Date or Time") unless value.is_a?(Time) || value.is_a?(Date)
      end
    end

    def output(value)
      value.strftime(format) if value
    end
  end
end
