module Datev
  class Export

    class << self
      attr_accessor :header_class, :row_class
    end

    def initialize()
      @rows = []
    end

    def <<(attributes)
      @rows << self.class.row_class.new(attributes)
    end

    def to_s
      csv = ""
      csv << self.class.row_class.fields.map(&:name).join(";") + "\n"
      @rows.each do |row|
        csv << self.class.row_class.fields.map { |f| f.output(row[f.name]) }.join(";") + "\n"
      end
      csv.encode(Encoding::ISO_8859_1)
    end

    def to_file(filename)
      File.open(filename, 'wb:ISO-8859-1') do |csv|
        csv.write(self.to_s)
      end
    end
    
  end
end
