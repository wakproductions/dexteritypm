## Dexterity Project Manager
#### An Agile Project Management Tool

This is a Rails application for collaborating on a software development project using Agile methodologies. The idea
for this system was spawned out of doing consulting work for bootstrap stage startups but not having a good tool for
communicating ideas and progress on technical work to my clients. There are numerous commercial programs out there
for Agile development, but I could not find one that is intuitive for non-technical end-users and for a price that
can't be beat (free!).

Dexterity PM is currently an open source project. For an rundown on the basic concepts of how this tool works, please
see the file [CONCEPTS.md](CONCEPTS.md).

Feel free to log a Github issue ticket or make pull requests for any new features you would like to add.


### Cucumber Test Notes

When doing

    > rake cucumber

you might get the following error message:

    /.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/gems/minitest-4.7.5/lib/minitest/unit.rb:1037:in `block in process_args': invalid option: --profile (OptionParser::InvalidOption)

It seems you can avoid this error by running cucumber as

    > bundle exec cucumber