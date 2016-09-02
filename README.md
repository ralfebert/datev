# Datev

Ruby gem for exporting bookings to DATEV via CSV file

[![Build Status](https://travis-ci.org/ledermann/datev.svg?branch=master)](https://travis-ci.org/ledermann/datev)
[![Code Climate](https://codeclimate.com/github/ledermann/datev/badges/gpa.svg)](https://codeclimate.com/github/ledermann/datev)
[![Coverage Status](https://coveralls.io/repos/github/ledermann/datev/badge.svg?branch=master)](https://coveralls.io/github/ledermann/datev?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'datev'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install datev

## Usage

```ruby
export = Datev::BookingExport.new()

export << {
  'Belegdatum'                     => Date.new(2016,6,21),
  'Buchungstext'                   => 'Fachbuch: Controlling für Dummies',
  'Umsatz (ohne Soll/Haben-Kz)'    => 24.95,
  'Soll/Haben-Kennzeichen'         => 'H',
  'Konto'                          => 1200,
  'Gegenkonto (ohne BU-Schlüssel)' => 4940,
  'BU-Schlüssel'                   => '8'
} # For available hash keys see /lib/datev/booking.rb

export << {
  'Belegdatum'                     => Date.new(2016,6,22),
  'Buchungstext'                   => 'Honorar FiBu-Seminar',
  'Umsatz (ohne Soll/Haben-Kz)'    => 5950.00,
  'Soll/Haben-Kennzeichen'         => 'S',
  'Konto'                          => 10000,
  'Gegenkonto (ohne BU-Schlüssel)' => 8400,
  'Belegfeld 1'                    => 'RE201606-135'
}

export.to_file('Buchungsstapel.csv')
```

Result: [CSV file](examples/EXTF_Buchungsstapel.csv)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ledermann/datev. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
