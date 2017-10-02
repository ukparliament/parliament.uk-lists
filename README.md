# Parliament.uk-lists
[Parliament.uk-lists](https://github.com/ukparliament/parliament.uk-lists "Parliament.uk-lists") is a [Rails](http://rubyonrails.org/) application designed to hold the list elements of the new [parliament.uk](http://www.parliament.uk/) website made by the [Parliamentary Digital Service](https://github.com/ukparliament "Parliamentary Digital Service").

### Contents
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Lists Rails Application](#parliament-rails-application)
  - [Running the application](#running-the-application)
  - [Running the tests](#running-the-tests)
- [Contributing](#contributing)
- [License](#license)

## Requirements
[[Parliament.uk-lists](https://github.com/ukparliament/parliament.uk-lists "Parliament.uk-lists") requires the following:
* [Ruby](https://www.ruby-lang.org/en/)
* [Bundler](http://http://bundler.io/)


## Getting Started
Clone the repository:
```bash
git clone https://github.com/ukparliament/parliament.uk-lists.git
cd parliament.uk-lists
```

#### Lists Rails Application
The [Parliament.uk-lists](https://github.com/ukparliament/parliament.uk-lists "Parliament.uk-lists") application holds the routes, controllers and views that make up all the list elements of the new [parliament.uk](http://www.parliament.uk/) website. A list is anything that can contain more than one item.

### Running the application
To run the application locally, run:
```bash
bundle install

bundle exec rails s
```

### Running the tests
We use [RSpec](http://rspec.info/) as our testing framework and tests can be run using:
```bash
bundle exec rspec
```

## Contributing
If you wish to submit a bug fix or feature, you can create a pull request and it will be merged pending a code review.

1. Fork the repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Ensure your changes are tested using [Rspec][rspec]
6. Create a new Pull Request

## License
