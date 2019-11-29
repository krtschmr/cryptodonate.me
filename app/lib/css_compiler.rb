class CssCompiler

  attr_accessor :streamer, :variables

  def self.run(streamer, variables)
    new(streamer, variables).compile!
  end

  def initialize(streamer, variables)
    self.streamer = streamer
    self.variables = variables
  end

  def compile!
    create_file_unless_exist
    load_template
    compile_template
    save_stylesheet
  end

  private

  def load_template
    erb_template = File.read("./app/assets/stylesheets/donation_template.scss.erb")
    @template = ERB.new(erb_template).result(binding)
  end

  def compile_template
    @compiled_css = SassC::Engine.new(@template, style: :compressed).render
  end

  def save_stylesheet
    File.open(css_output_file, "w") {|f| f.write(@compiled_css) }
  end

  def create_file_unless_exist
    FileUtils.mkdir_p("./public/styles") unless File.directory?('./public/styles')
    File.open(css_output_file, "w") unless File.exist?(css_output_file)
  end

  def css_output_file
    "#{Rails.root}/public/styles/#{streamer.uuid}.css"
  end

end
