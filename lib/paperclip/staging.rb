require "paperclip/staging/version"

module Paperclip
  module Staging
  end
end

class NamedStringIO < StringIO
  attr_accessor :original_filename
  attr_accessor :content_type

  def initialize(text, filename, type)
    super(text)
    self.original_filename = filename
    self.content_type = type
  end
end

# module UrlGeneratorExtensions
#   def for(style_name, options)
#   end
# end

module AttachmentExtensions
  def staged_url(style_name = default_style, options = {})
    queued = queued_for_write[style_name]
    if queued
      data = Base64.strict_encode64(File.read(queued.path))
      "data:#{queued.content_type};base64,#{data}"
    else
      url(style_name, options)
    end
  end
end

module HasAttachedFileExtensions
  def define
    super
    define_accessor_staging
  end

  def define_accessor_staging
    name = @name
    staging_getter_name = "#{name.to_s}_staging".to_sym
    staging_setter_name = "#{name.to_s}_staging=".to_sym

    already_updated_ivar = "@attachment_#{name}_already_updated".to_sym

    @klass.send :define_method, staging_getter_name do
      ivar = "@attachment_#{name}"
      attachment = instance_variable_get(ivar)
      return nil unless attachment
      queued = attachment.queued_for_write[:original]
      if queued
        filename = attachment.original_filename
        type = attachment.content_type
        body = File.read(queued.path)
        [filename, type, body].map{|text|Base64.strict_encode64(text)}.join('|')
      end
    end

    old_attachment_setter = "#{name.to_s}_original_setter".to_sym
    @klass.send :alias_method, old_attachment_setter, "#{@name}="

    @klass.send :define_method, "#{@name}=" do |file|
      instance_variable_set(already_updated_ivar, true)
      send(old_attachment_setter, file)
    end

    @klass.send :define_method, staging_setter_name do |value|
      return if value.blank?
      already_updated = instance_variable_get(already_updated_ivar)
      return if already_updated
      filename, type, body = value.split('|').map{|text|Base64.strict_decode64(text)}
      send(name).assign(NamedStringIO.new(body, filename, type))
    end
  end
end

module Paperclip
  class Attachment
    prepend AttachmentExtensions
  end

  # class UrlGenerator
  #   prepend UrlGeneratorExtensions
  # end

  class HasAttachedFile
    prepend HasAttachedFileExtensions
  end
end
