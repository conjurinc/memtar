# MemTar

In-memory tar archive creation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'memtar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install memtar

## Usage

```ruby

require 'memtar'

archive = MemTar.new
archive.default[:uname] = "nobody"

archive.add_file "foo", "content", mode: 0640
archive.add_file "bar/baz", "hi!"
archive.add_symlink "bar/xyzzy", "baz"
archive.add_file "this", File.new("/etc/passwd") # copies attributes and content

File.write "test.tar", archive.to_s
```

## Contributing

We welcome contributions of all kinds to this repository. For instructions on
how to get started and descriptions of our development workflows, please see our
[contributing guide](CONTRIBUTING.md).
