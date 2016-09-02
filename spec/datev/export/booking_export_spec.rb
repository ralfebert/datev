# encoding: UTF-8
require 'spec_helper'

describe Datev::BookingExport do
  let(:booking1) {
    {
      'Belegdatum'                     => Date.new(2016,6,21),
      'Buchungstext'                   => 'Fachbuch: Controlling für Dummies',
      'Umsatz (ohne Soll/Haben-Kz)'    => 24.95,
      'Soll/Haben-Kennzeichen'         => 'H',
      'Konto'                          => 1200,
      'Gegenkonto (ohne BU-Schlüssel)' => 4940,
      'BU-Schlüssel'                   => '8'
    }
  }

  let(:booking2) {
    {
      'Belegdatum'                     => Date.new(2016,6,22),
      'Buchungstext'                   => 'Honorar FiBu-Seminar',
      'Umsatz (ohne Soll/Haben-Kz)'    => 5950.00,
      'Soll/Haben-Kennzeichen'         => 'S',
      'Konto'                          => 10000,
      'Gegenkonto (ohne BU-Schlüssel)' => 8400,
      'Belegfeld 1'                    => 'RE201606-135'
    }
  }

  let(:export) do
    export = Datev::BookingExport.new()
    export << booking1
    export << booking2
    export
  end

  describe :initialize do
    it "should initialize without error" do
      expect {
        Datev::BookingExport.new()
      }.to_not raise_error
    end
  end

  describe :to_s do
    subject { export.to_s }

    it 'should export as string' do
      expect(subject).to be_a(String)
      expect(subject.lines.length).to eq(3)
    end

    it "should encode in Windows-1252" do
      expect(subject.encoding).to eq(Encoding::WINDOWS_1252)
    end

    it "should contain field names" do
      expect(subject.lines.first).to include('Umsatz (ohne Soll/Haben-Kz);Soll/Haben-Kennzeichen')
    end

    it "should contain bookings" do
      expect(subject.lines[1]).to include('4940')
      expect(subject.lines[1].encode(Encoding::UTF_8)).to include('Controlling für Dummies')

      expect(subject.lines[2]).to include('8400')
      expect(subject.lines[2].encode(Encoding::UTF_8)).to include('Honorar FiBu-Seminar')
    end
  end

  describe :to_file do
    it 'should export a valid CSV file' do
      Dir.mktmpdir do |dir|
        filename = "#{dir}/EXTF_Buchungsstapel.csv"
        export.to_file(filename)

        expect {
          CSV.read(filename, Datev::Export::CSV_OPTIONS)
        }.to_not raise_error
      end
    end

    it 'should export a file identically to the given example' do
      Dir.mktmpdir do |dir|
        filename = "#{dir}/EXTF_Buchungsstapel.csv"
        export.to_file(filename)

        expect(IO.read(filename)).to eq(IO.read('examples/EXTF_Buchungsstapel.csv'))
      end
    end
  end
end
