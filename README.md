# ruby_struct_keyword
Experiment how flexible ruby can be

## Why
I just wanted to try out how flexible ruby can be. And if I can create something that feels as a natural part of language within that language. There are no dependencies, no gems, no magic, just a simple DSL. But with usage of `const_missing` and `caller` I was able to create something that feels like a natural part of the language.
## Usage

```ruby
require 'ruby_struct_keyword'

struct User do
  property :name
end

user = User.new(name: 'Karolo')
user.name # => 'Karolo'
```

## Installation

Download or copy the file `ruby_struct_keyword.rb` into your project.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).