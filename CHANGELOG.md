# Unreleased

 * [BREAKING] Drop support for Active Record 3.0, 3.1, 3.2 and 4.0; only Active Record 4.2 (Rails LTS) is supported
 * [FIX] Restore the default `number ASC` ordering of the versions association, which was lost in the Rails 4 port when `has_many` dropped its `:order` option
 * [FIX] `Versions#between` replaces the association's ordering rather than appending to it
 * The test suite now runs on Ruby 3.3 against PostgreSQL, under RSpec 3

# 2.0.0 / 2014-01-20

 * [ENHANCEMENT] Ruby 2.1.0 compatibility
 * [ENHANCEMENT] Ruby 2.0.0 compatibility
 * [ENHANCEMENT] Ruby 1.9.3 compatibility
 * [ENHANCEMENT] Initial Rails 4 compatibility
 * [ENHANCEMENT] Initial Rails 3 compatibility
