## oj-pstore gem

This gem implements a [PStore](http://ruby-doc.org/stdlib-2.0/libdoc/pstore/rdoc/PStore.html) alternative using the fast [Oj](https://github.com/ohler55/oj#readme) gem.

- Gem: [rubygems.org](https://rubygems.org/gems/oj-pstore)
- Source: [github.com](https://github.com/mblumtritt/oj-pstore)

Use [Bundler](http://gembundler.com/) to add TCPClient in your own project:

Include in your `Gemfile`:

```ruby
gem 'oj-pstore'
```

and install it by running Bundler:

```bash
bundle
```

To install the gem globally use:

```bash
gem install oj-pstore
```

After that you need only a single line of code in your project to have it on board:

```ruby
require 'oj/store'
```
## Documentation

The gem supports the [PStore](https://ruby-doc.org/stdlib-2.7.0/libdoc/pstore/rdoc/index.html) API.

## Sample

```ruby
# change a configuration value
require 'oj/store'

config = Oj::Store.new('config.json')
config.transaction{ config[:last_used] = Time.now }
```
