require "../spec_helper"

describe MartenMjml::Template::Template do
  it "renders a template with variables and conditionals correctly" do
    loader = MartenMjml::Template::Loader::Mjml.new("#{__DIR__}/templates")
    template = loader.get_template("list.mjml")

    # Define context with dynamic data
    context = Marten::Template::Context{
      "name" => "Alice",
      "show_items" => true,
      "items" => ["Apple", "Banana", "Strawberry"],
    }

    # Render the template with context
    html_output = template.render(context)

    html_output.should contain "Alice"
    html_output.should contain "Items:"
    html_output.should contain "- Apple"
    html_output.should contain "- Banana"
    html_output.should contain "- Strawberry"
  end

  it "correctly omits sections when conditionals are false" do
    loader = MartenMjml::Template::Loader::Mjml.new("#{__DIR__}/templates")
    template = loader.get_template("list.mjml")

    # Define context with dynamic data
    context = Marten::Template::Context{
      "name" => "Alice",
      "show_items" => false,
      "items" => ["Apple", "Banana", "Strawberry"],
    }

    # Render the template with context
    html_output = template.render(context)
    html_output.should contain "Alice"
    html_output.should_not contain "Items:"
  end
end

# describe "asd" do
#   it "asd" do
#     puts "#{__DIR__}/templates"
#     loader = MartenMjml::Template::Loader::Mjml.new("#{__DIR__}/templates")
#     s = loader.get_template("hello.mjml")

#     puts s.class

#     puts s.render(
#       Marten::Template::Context{
#         "name" => "John Doe",
#         "show_items" => false,
#         "items" => ["Apple", "Banana", "Strawberry"],
#       }
#     )
#   end
# end
