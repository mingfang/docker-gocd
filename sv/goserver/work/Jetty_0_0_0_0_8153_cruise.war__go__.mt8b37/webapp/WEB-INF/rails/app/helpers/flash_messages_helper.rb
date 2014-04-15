module FlashMessagesHelper
  def flash_message_pane_start id, no_body = false, options = {}
    "<div class=\"flash\" id=\"#{id}\">" + (no_body ? flash_message_pane_end : "")
  end

  def flash_message_pane_end
    "</div>"
  end
end