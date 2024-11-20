module MartenMjml
  module Template
    module Loader
      class Mjml < Marten::Template::Loader::FileSystem
        def get_template(template_name) : Marten::Template::Template
          Template.new(get_template_source(template_name))
        rescue e : Marten::Template::Errors::InvalidSyntax
          if Marten.settings.debug && e.filepath.nil?
            e.filepath = File.join(@path, template_name).to_s
          end

          raise e
        end
      end
    end
  end
end
