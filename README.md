# Toy Robot Aplication

## Description / About

You can have the full description of the challenge ['here'](readme/CODING_CHALLENGE.md)

## Development

### Environment

* MacOSX
* Ruby 2.3.1
* Bundler

### Requirements

* This was developed using Ruby 2.3.1, but will probably work in Ruby > 2+.
* Terminal with bash installed or POSIX compatible term.

### Tools used

* Bundler
* Thor

### Documentation
Code should be simple to understand. Methods and classes should tell you what 
they are responsible for and what they do just by their names. 
However, some design decisions may be a bit obscure to understand at a glance
and when it happens, documentation can be handy for those not aware with 
the project and the design decisions.

Some methods and classes in the conditions above are documented following 
the ['TomDoc'](tomdoc.org)

### Usage / Installation

Clone the project
`$ git clone git@bitbucket.org:sapienza/toy_robot.git`

Navigate to the `toyrobot` folder and run:
`$ gem install bundler`
`$ bundle install`

### Usage

```bash
$ bin/toy_robot --help

Commands:
  bin/toy_robot execute --instructions-file=./example_data/instructions_1.txt  # executes given commands
  bin/toy_robot help [COMMAND]                                                 # Describe available commands or one specific command
```

### Commands Accepted and its options
Under config/commands.yml


### Running Tests
`$ bundle exec rspec spec`

### Test Coverage Metrics

To run test coverage tool (SimpleRCov).
`$ COVERAGE=true bundle exec rspec spec`

Here is the current state:
!['model'](/readme/images/coverage.png)

### Ruby static code analyzer (Rubocop).
`$ bundle exec rubocop`

## Contributing

This project doesn't currently accept contributions.

## License

This project is available as open source under the terms of the ['MIT license'](LICENSE).