class Admin::CommandsController < AdminController

  layout nil

  def index
    @invalid_commands = command_repository_service.getAllInvalidCommandSnippets()
    @invalid_commands.sort! { |o1, o2| o1.getBaseFileName() <=> o2.getBaseFileName() }
  end

  def show
    relative_path_of_snippet = params[:command_name]
    definition = command_repository_service.getCommandSnippetByRelativePath(relative_path_of_snippet)
    render :text => "Command Definition for '#{relative_path_of_snippet}' could not be found", :status => 404 and return if definition.nil?

    render :json => {:name => definition.getName(), :description => definition.getDescription(), :author => definition.getAuthor(), :authorinfo => definition.getAuthorInfo(),
        :moreinfo => definition.getMoreInfo(), :command => definition.getCommandName(), :arguments => definition.getArguments().join("\n")}
  end

  def lookup
    matched_command_snippets = command_repository_service.lookupCommand(params[:lookup_prefix])

    render :text => matched_command_snippets.collect {|snippet| "#{snippet.getName()}|#{snippet.getRelativePath()}"}.join("\n")
  end
end