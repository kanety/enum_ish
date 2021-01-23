# CHANGELOG

## 1.3.3

* Support rails 6.1.

## 1.3.2

* Fix deprecation warning for ruby 2.7.

## 1.3.1

* Fix default value for model included ActiveModel.

## 1.3.0

* Support array field.

## 1.2.3

* Keep enum definitions as a hash internally.

## 1.2.2

* Support assignment of string in addition to symbol.

## 1.2.1

* Fix internal module name.

## 1.2.0

* Register enum definitions in the class.
* Add configuration for method name prefix and suffix.
* Use ActiveRecord::Type for accessor definition.
* Raise errors if scope is used for non ActiveRecord class.
* Refactoring.

## 1.1.1

* Fix lack of options when some enums have same translation.

## 1.1.0

* Support translation for scoped query.
* Support block for default value.
* Add :only and :except for options method.

## 1.0.0

* First release.
