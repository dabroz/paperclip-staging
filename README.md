# Paperclip::Staging

Allow [Paperclip](https://github.com/thoughtbot/paperclip) to pass attachments as data-uri on unsaved records. Useful when dealing with forms and validation errors.

Imagine you have two fields on a model - `name` and `attachment`. Let's say that `name` has a validation. If you edit an object and change both `name` and `attachment`, but the new name doesn't meet the validation, then you lose the new `attachment`.

With paperclip-staging, the attachment is preserved using a hidden field. It is also available with `staged_url(style_name)` (instead of regular `url(style_name)`) calls, using data-uri encoding - which is useful if you want to display current value for the attachment/image.

You can check the [example project](https://github.com/dabroz/paperclip-staging-example).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paperclip-staging'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paperclip-staging

## Usage

1. Add a new hidden field in the form, named `<attachment_name>_staging`.

    `f.hidden_field :file_staging`
    
    or
    
    `f.input :file_staging, as: :hidden` for `simple_form`

2. Add this field as a valid form param:

    `attr_accessible :file_staging`

    or

    `params.require(xxx).permit(xxx, :file_staging)` for Rails 4

3. That's it!

## Contributing

1. Fork it ( https://github.com/dabroz/paperclip-staging/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
