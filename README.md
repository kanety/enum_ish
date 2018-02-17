# EnumIsh

A ruby and rails extension to generate enum-like methods.

## Dependencies

* ruby 2.3+
* activesupport 5.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enum_ish'
```

Then execute:

    $ bundle

## Usage

Extend your class using EnumIsh and define an enum-like field:

```ruby
class User
  extend EnumIsh
  attr_accessor :status                    # status is a string field
  enum_ish :status, ['enable', 'disable']  # status has 'enable' or 'disable'
end
```

Then define i18n translations (example below shows japanese translations):

```yaml
ja:
  enum_ish:
    user:
      enable: 有効
      disable: 無効
```

Enum-like methods are generated as follows:

```ruby
user = User.new
user.status = 'enable'
user.status_text     #=> "有効"
User.status_options  #=> [["有効", "enable"], ["無効", "disable"]]
```

### Additional translations

Define additional translations:

```yaml
ja:
  enum_ish:
    user:
      status:
        enable: 有効
        disable: 無効
      status/short:
        enable: 有
        disable: 無
```

```ruby
user = User.new
user.status = 'enable'
user.status_text(format: :short)     #=> "有"
User.status_options(format: :short)  #=> [["有", "enable"], ["無", "disable"]]
```

### Default value

Set default value:

```ruby
class User
  extend EnumIsh
  attr_accessor :status
  enum_ish :status, ['enable', 'disable'], default: 'enable'
end

user = User.new
user.status  #=> "enable"
```

### Predicates

Generate predicate methods:

```ruby
class User
  extend EnumIsh
  attr_accessor :status
  enum_ish :status, ['enable', 'disable'], predicate: true
end

user = User.new
user.status = 'enable'
user.status_enable?   #=> true
user.status_disable?  #=> false
```

### Accessor

Generate getter and setter for aliased symbols instead of raw values:

```ruby
class User
  extend EnumIsh
  attr_accessor :status
  enum_ish :status, { _enable: 'enable', _disable: 'disable' }, accessor: true
end

user = User.new
user.status = :_enable
user.status              #=> :_enable
user.status_raw          #=> "enable"
```

### Scope (for ActiveRecord)

Generate scope:

```ruby
class User < ActiveRecord::Base
  extend EnumIsh
  enum_ish :status, ['enable', 'disable'], scope: true
end

User.with_status(:enable)  #=> SELECT "users".* FROM "users" WHERE "users"."status" = "enable"
```

### Validation (for ActiveRecord)

Generate validation:

```ruby
class User < ActiveRecord::Base
  extend EnumIsh
  enum_ish :status, ['enable', 'disable'], validate: true
end

user = User.new
user.status = 'INVALID'
user.valid?  #=> false
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/enum_ish.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
