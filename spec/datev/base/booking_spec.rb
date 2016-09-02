require 'spec_helper'

describe Datev::Booking do
  describe :initialize do
    it "should be allowed with all required fields" do
      expect {
        Datev::Booking.new(
          'Umsatz (ohne Soll/Haben-Kz)'    => 100.12,
          'Soll/Haben-Kennzeichen'         => 'S',
          'Konto'                          => 1000,
          'Gegenkonto (ohne BU-Schlüssel)' => 1200,
          'Belegdatum'                     => Date.new(2016,6,20),
          'Buchungstext'                   => 'ATM'
        )
      }.to_not raise_error
    end

    it "should not be allowed if fields are missing" do
      expect {
        Datev::Booking.new 'Umsatz (ohne Soll/Haben-Kz)' => 100.12
      }.to raise_error(ArgumentError, "Value for field 'Soll/Haben-Kennzeichen' is required but missing")
    end
  end

  describe :output, 'account numbers' do
    let(:booking) {
      Datev::Booking.new(
        'Umsatz (ohne Soll/Haben-Kz)'    => 100,
        'Soll/Haben-Kennzeichen'         => 'S',
        'Konto'                          => 400,
        'Gegenkonto (ohne BU-Schlüssel)' => 70000,
        'Belegdatum'                     => Date.today
      )
    }

    it "should pad strings with zeros" do
      output = booking.output()

      expect(output[6]).to eq('0400')
      expect(output[7]).to eq('70000')
    end

  end
end
