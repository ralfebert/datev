module Datev
  class BooleanField < Field
    def validate!(value)
      super

      unless value.nil?
        raise ArgumentError.new("Value given for field '#{name}' is not a Boolean") unless [true, false].include?(value)
      end
    end

    def output(value)
      value ? 1 : 0 unless value.nil?
    end
  end
end
