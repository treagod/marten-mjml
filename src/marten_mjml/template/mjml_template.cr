module MartenMjml
  module Template
    class Template < Marten::Template::Template
      def render(context : Marten::Template::Context? = nil) : String
        convert_to_mjml(
          @nodes.render(context || Marten::Template::Context.new)
        )
      end

      private def convert_to_mjml(template : String)
        stdout = IO::Memory.new
        # Todo: Use strategy pattern
        Process.run("mjml -s -i --noStdoutFileComment", shell: true, output: stdout) do |process|
          process.input.print template
        end

        stdout.to_s
      end
    end
  end
end
