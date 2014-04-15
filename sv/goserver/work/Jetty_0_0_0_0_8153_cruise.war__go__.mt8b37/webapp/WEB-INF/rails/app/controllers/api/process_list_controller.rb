class Api::ProcessListController < Api::ApiController
  def process_list
    @process_list = ProcessManager.getInstance().currentProcessListForDisplay();
    @str = "<html><body><table border=\"1\">"
    @process_list.each do |process|
      @str += "<tr><td>" + process.getCommand() + "</td><td>" + process.getStartTimeForDisplay() + "</td><td>" + (process.getIdleTime() / 60000).to_s + " minutes</td></tr>"
    end
    @str += "</table></body></html>"
    render :text => @str
  end
end