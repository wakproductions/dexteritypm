## Dexterity Project Manager
#### An Agile Project Management Tool

This is a Rails application for collaborating on a software development project using Agile methodologies. It is
currently an open source project. Please feel free to make pull requests for any new features you would like to add.


### Cucumber Test Notes

When doing

    > rake cucumber

you might get the following error message:

    /.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/gems/minitest-4.7.5/lib/minitest/unit.rb:1037:in `block in process_args': invalid option: --profile (OptionParser::InvalidOption)

It seems you can avoid this error by running cucumber as

    > bundle exec cucumber