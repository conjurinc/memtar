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

1. Fork it ( https://github.com/[my-github-username]/memtar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
